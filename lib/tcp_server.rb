require 'socket'
require_relative 'request'
require_relative 'router'
require_relative 'response'

class HTTPServer
    def initialize(port, router)
        @port = port
        @router = router

        @mime_types = {
            "html" => "text/html",
            "css" => "text/css",
            "js" => "application/javascript",
            "png" => "image/png",
            "jpg" => "image/jpeg",
            "jpeg" => "image/jpeg",
            "gif" => "image/gif",
            "svg" => "image/svg+xml",
            "json" => "application/json",
            "txt" => "text/plain"
        }
    end

    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"

        while session = server.accept
            data = ""
            while line = session.gets and line !~ /^\s*$/
                data += line
            end

            puts "RECEIVED REQUEST"
            puts "-" * 40
            puts data
            puts "-" * 40 

            request = Request.new(data)
            pp request
            #router = Router.new
            route = @router.match_route(@arr_of_routes, request.resource)

            if route
                body = route[-1].call
                status = 200
                content_type = "text/html"
            elsif File.exist?("./public#{request.resource}")
                body = File.binread("./public#{request.resource}")
                p body

            else
                body = "<h1>404 page not found?</h1>"
                status = 404
                content_type = "text/html"
            end

            response = Response.new(session, request)
            response.send(status, body, content_type)


            # session.print "HTTP/1.1 #{status}\r\n"
            # session.print "Content-Type: #{content_type}\r\n"
            # session.print "\r\n"
            # session.print body
            # session.close
        end
    end
end

