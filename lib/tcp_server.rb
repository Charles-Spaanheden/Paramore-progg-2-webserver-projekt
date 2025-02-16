require 'socket'
require_relative 'request'
require_relative 'router'
require_relative 'response'

class HTTPServer

    def initialize(port)
        @port = port
    end

    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"
        router = Router.new
        
        router.add_route(:get,"/banan") do
           File.read("../block.html")
        end
        
        router.add_route(:get, "/test1") do
            "<h1>Test</h1>"
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


            route = router.match_route(@arr_of_routes,request)
            
            if route
                html = route[-1].call
                status = 200
            # elsif #finns filen i public?
                #mdn mime_types
                # pp "Hey"
            else
                html = "<h1>404 page not found?</h1>"
                status = 404
            end
            #Sen kolla om resursen (filen finns)





            # Nedanstående bör göras i er Response-klass soooooooon
            session.print "HTTP/1.1 #{status}\r\n"
            session.print "Content-Type: text/html\r\n"
            session.print "\r\n"
            session.print html
            session.close
        end
    end
end
server = HTTPServer.new(4567)
server.start