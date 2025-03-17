require 'socket'
require_relative 'request'
require_relative 'router'
require_relative 'response'
require_relative '../app'
class HTTPServer
    def initialize(port)
        @port = port
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
        router = Router.new
        
        router.add_route(:get, "/banan") do
           File.read("./public/block.html")  
        end
        
        router.add_route(:get, "/test1") do
            "<h1>Test</h1>"
        end
        
        router.add_route(:get, "/") do
            "<h1> / / / / / / /</h1>"
        end

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

            route = router.match_route(@arr_of_routes, request)


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

            session.print "HTTP/1.1 #{status}\r\n"
            session.print "Content-Type: #{content_type}\r\n"
            session.print "\r\n"
            session.print body
            session.close
        end
    end
end

server = HTTPServer.new(4567)
server.start
