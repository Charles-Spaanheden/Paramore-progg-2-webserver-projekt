class Response
    # initializes session and request objects
    # @param session [Request] the session object
    # @param request [Request] the request object
    # @return [Symbols] the send method
    def initialize(session,request)
        @session = session
        @request = request
    end

    # prints information from the request and route into the terminal and puts the body into the browser
    # @param status [Request] the status object
    # @param body [Request] the status object
    # @paran content_type [Request] the conent_type object
    # @return [void]
    def send(status, body, content_type)
        puts "SENDING RESPONSE"
        @session.print "HTTP/1.1 #{status}\r\n"
        @session.print "Content-Type: #{content_type}\r\n"
        @session.print "\r\n"
        @session.print body
        @session.close
    end
end