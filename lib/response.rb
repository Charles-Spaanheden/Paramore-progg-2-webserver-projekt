class Response
    def initialize(session,request)
        @session = session
        @request = request
    end

    def send(status, body, content_type)
        puts "SENDING RESPONSE"
        @session.print "HTTP/1.1 #{status}\r\n"
        @session.print "Content-Type: #{content_type}\r\n"
        @session.print "\r\n"
        @session.print body
        @session.close
    end
end