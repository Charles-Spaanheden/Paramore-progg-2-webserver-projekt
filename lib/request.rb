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
      params = @tolkningHash[-1].split("&") #tolkningString.include?('')
      #params = tolkningString[-1].split("&")
      parammap(params)
    end
    
    header_line = @tolkningHash[1..-1].take_while { |sak| sak != "\n"}
    @headers = header_line.map do |line|
      header_key, header_value = line.split(':', 2)
      [header_key.strip, header_value.strip] if header_key && header_value
    end.compact.to_h   #Hade velat göra på något annat sätt för det känns extremt fel att lägga metoder på end
    
    
    
    
    
    # puts @tolkningHash
    # puts @method
    # puts @resource
    # puts @version
    # puts @headers
    # puts @params
    
    

    #puts "Method: #{method}", "resource: #{resource}", "version: #{version}" # + headers + params
    #puts "Headers: #{@headers}"
    #puts @tolkningHash
    #p @tolkningHash&.map {|grej| grej.end_with?(":")}
  end
  attr_reader :method, :resource, :version, :headers, :params
end

#request_string = File.read('./test/example_requests/post-login.request.txt')
#request_string = File.read('./test/example_requests/get-examples.request.txt')
request_string = File.read('./test/example_requests\get-fruits-with-filter.request.txt')
Request.new(request_string)