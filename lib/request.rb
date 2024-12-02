# frozen_string_literal: true

class Request

  def parammap(param)
    param.map do |item|
      item = item.split("=")
      break if item[1] == nil
      @params[item[0]] = item[1]
    end
  end

  def initialize(tolkningString)
    @headers = {}
    @params = {}
    @tolkningHash = tolkningString.split("\n")
    ingen_hash_line = @tolkningHash[0].split(' ')
    @method, @resource, @version = ingen_hash_line
    @method = @method.downcase.to_sym

    if resource.include?("?")
      param = resource.split("?")
      param = param[1].split("&")
      parammap(param)
      @resource = @resource.split("?")[0]
    end

    if @tolkningHash[-1].strip != ""
      params = @tolkningHash[-1].split("&")
      parammap(params)
    end
    
    header_line = @tolkningHash[1..-1].take_while { |sak| sak != "\n"}
    @headers = header_line.map do |line|
      header_key, header_value = line.split(':', 2)
      [header_key.strip, header_value.strip] if header_key && header_value
    end.compact.to_h

    #p @method
    #p @resource
    #p @version
    #p @headers
    #p @params

  end
  attr_reader :method, :resource, :version, :headers, :params
end

#request_string = File.read('test/example_requests/post-login.request.txt')
#Request.new(request_string)