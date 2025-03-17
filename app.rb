require_relative './lib/router'

router = Router.new

router.add_route(:get, "/apptest") do
    "<h1>app app app app Test</h1>"
end