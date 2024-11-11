# frozen_string_literal: true

class Request
  def initialize(tolkningString)
    @headers = {}
    @params = {}
    @tolkningHash = tolkningString.split("\n")
    ingen_hash_line = @tolkningHash[0].split(' ')
    method, resource, version = ingen_hash_line
    header_line = @tolkningHash[1..-1].take_while { |sak| sak != "\n"}
    @headers = header_line.map do |line|
      header_key, header_value = line.split(':', 2)
      [header_key.strip, header_value.strip] if header_key && header_value
    end.to_h   #Hade velat göra på något annat sätt för det känns extremt fel att lägga metoder på end



    @tolkningHash


    #p ingen_hash_line
    #p @tolkningHash



    pp "Method: #{method}", "resource: #{resource}", "version: #{version}" # + headers + params
    pp "Headers: #{@headers}"
    pp @tolkningHash
    #p @tolkningHash&.map {|grej| grej.end_with?(":")}
  end
end

request_string = File.read('./test/example_requests/post-login.request.txt')
Request.new(request_string)