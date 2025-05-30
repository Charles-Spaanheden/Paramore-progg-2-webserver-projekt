require_relative './lib/router'
require_relative './lib/tcp_server'

router = Router.new

router.add_route(:get, "/favicon.ico") do
    File.binread("./public/img/sansundertale.png")
end

# router.add_route(:get, "/banan") do
#     File.read("./public/block.html")  
#  end

router.add_route(:get, "/dynamic/:id/testing") do
    "<h1>Dynamic Route</h1>"
end

router.add_route(:get, "/dynamic/:id/:another_id/testing") do
    "<h1>Dynamic Route with another thingie</h1>"
end


server = HTTPServer.new(4567, router)
server.start