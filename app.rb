require_relative './lib/router'
require_relative './lib/tcp_server'

$router = Router.new

$router.add_route(:get, "/apptest") do
    "<h1>app app app app Test</h1>"
end

$router.add_route(:get, "/banan") do
    File.read("./public/block.html")  
 end
 
 $router.add_route(:get, "/test1") do
     "<h1>Test</h1>"
 end