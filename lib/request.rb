# frozen_string_literal: true

class Request

  # Handles splitting and insertion of items into @params
  # @param param [Request] the param object
  # @return [Hash] the @params hash
  def parammap(param)
    param.map do |item|
      item = item.split("=")
      break if item[1] == nil
      @params[item[0]] = item[1]
    end
  end

  # Handles the HTTP request string and parses it into headers,params,method,resource and version accordingly
  # @param tolkningString [Request] the unmodified HTTP request string
  # @return the parsed objects in attr_reader keys
  def initialize(tolkningString)
    @headers = {}
    @params = {}
    tolkningHash = tolkningString.split("\n")
    ingen_hash_line = tolkningHash[0].split(' ')
    @method, @resource, @version = ingen_hash_line
    @method = @method.downcase.to_sym

    if resource.include?("?")
      param = resource.split("?")
      param = param[1].split("&")
      parammap(param)
      @resource = @resource.split("?")[0]
    end

    if tolkningHash[-1].strip != ""
      params = tolkningHash[-1].split("&")
      parammap(params)
    end
    
    header_line = tolkningHash[1..-1].take_while { |sak| sak != "\n"}
    @headers = header_line.map do |line|
      header_key, header_value = line.split(':', 2)
      [header_key.strip, header_value.strip] if header_key && header_value
    end.compact.to_h

  end
  attr_reader :method, :resource, :version, :headers, :params
end

#request_string = File.read('test/example_requests/post-login.request.txt')
#Request.new(request_string)