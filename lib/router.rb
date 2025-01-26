# frozen_string_literal: true
class Router
    def initialize
        @arr_of_routes = []
    end

    def add_route(type,name)
     if type == :get || type == :post
         route_arr = [type,name]
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
        for routes in @arr_of_routes do
            if routes == browser_routes
                p "Route Found"

                return true
            end
        end
        p "Route Not Found"
        return false
    end
end