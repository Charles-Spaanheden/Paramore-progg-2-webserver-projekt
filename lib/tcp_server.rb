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
           "<h1>Hello, World banan?!</h1> <h2>bananbananbanan</h2>"
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

            # if request.resource == "/"
            #     html = "<h1>Hello, World //!</h1>"
            #     status = 200
            # elsif request.resource == "/banan"
            #     html = "<h1>Hello, World banan?!</h1> <h2>bananbananbanan</h2>"
            # elsif request.resource == "/test1"
            #     html = "<h1>Test</h1>"
            # else
            #     html = "<h1>Hello, World!</h1>"
            #     status = 404          
            # end


            route = router.match_route(@arr_of_routes,request)
            
            if route
                html = "<h1>Hello, World //!</h1>"
                status = 200
            else
                html = "<h1>Oh noes, World!</h1>"
                status = 404
            end
            #Sen kolla om resursen (filen finns)



            # Nedanstående bör göras i er Response-klass


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