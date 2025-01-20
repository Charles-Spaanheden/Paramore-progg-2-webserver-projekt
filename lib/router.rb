# frozen_string_literal: true
class Router
    def initialize
        @arr_of_routes = []
    end

    def add_route(type,name)
     if type == :get || type == :post
         route_arr = [type,name]
         @arr_of_routes << route_arr
        end
    end

    def match_route(source,browser)
        browser_routes = [@method,@resource]
        for routes in @arr_of_routes do
            if routes == browser_routes
                return 
            end
        end
    end
end