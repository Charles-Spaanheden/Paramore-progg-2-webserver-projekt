# frozen_string_literal: true
class Router
    def initialize
        @arr_of_routes = []
    end

    def add_route(type,name,&block)
     if type == :get || type == :post
         route_arr = [type,name,block]
         @arr_of_routes << route_arr
         p @arr_of_routes
        end
    end

    def match_route(source,browser)
        p "-----------------------------------------------"
        browser_routes = [browser.method,browser.resource]
        p browser_routes
        p @arr_of_routes
        p "Matching Route"
        for route in @arr_of_routes do
            p route
            p browser_routes
            if route[0..1] == browser_routes
                p "Route Found"

                return route
            end
        end
        p "Route Not Found"
        return false
    end
end