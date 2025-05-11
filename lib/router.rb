# frozen_string_literal: true
class Router
    def initialize
        @arr_of_routes = []
    end

    def add_route(type,name,&block)
     if type == :get || type == :post
         route_arr = [type,name,block]
         #TODO: Split name
         @arr_of_routes << route_arr
         p @arr_of_routes
        end
    end

    def match_route(request)
        p request
        dynamicbrowser = request.resource.split("/")
        p dynamicbrowser
        # "/user/5/banan/8"
        @arr_of_routes.each do |route|
            splitted_route = route[1].split("/")
            p splitted_route
            # "/user/:id/banan/:banan"

            if splitted_route.length == dynamicbrowser.length
                matchning = true
                p "#{splitted_route} och #{dynamicbrowser} är lika långa"
                splitted_route.each_with_index do |part, index|
                    if part.include?(":")
                        request.params[part] = dynamicbrowser[index]
                        p request.params
                    elsif part == dynamicbrowser[index]
                        next
                    else
                        matchning = false
                        request.params.clear
                        break 
                    end
                end
            end
            if matchning
                return route
            end
        end
    end
end
        # p dynamicbrowser
        # dynamicbrowser.each do |dynamic|
        #     p "hej"
        #     if dynamic.include?(":")
        #         p ": hittat"     

    #     p "-----------------------------------------------"
    #     browser_routes = [browser.method,browser.resource]
    #     p browser_routes
    #     p @arr_of_routes
    #     p "Matching Route"
    #     for route in @arr_of_routes do
    #         p route
    #         p browser_routes
    #         if route[0..1] == browser_routes
    #             p "Route Found"

    #             return route
    #         end
    #     end
    #     p "Route Not Found"
    #     return false
    # end

