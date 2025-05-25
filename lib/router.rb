# frozen_string_literal: true
class Router
    # initializes local arr_of_routes array
    # @return [Symbol] arr_of_routes array 
    def initialize
        @arr_of_routes = []
    end

    # if format is correct, creates a route into the arr_of_routes array
    # @param type [Request] the type object
    # @param name [Request] the name object
    # @param block [Request] the block object
    # @return [Array] the arr_of_routes array
    def add_route(type,name,&block)
     if type == :get || type == :post
        pp "detta är name: #{name}"            
         route_arr = [type,name,block]         
         #TODO: Split name  
         @arr_of_routes << route_arr
         p @arr_of_routes
        end
    end

    # matches route received from HTTPServer and parses them if matching
    # routes with keys have their key and value inserted into request.params
    # @param request [Request] the request object
    # @return [Array(nil, String, String, Proc), nil] the matching route if found
    def match_route(request)
        p request
        dynamicbrowser = request.resource.split("/")
        p dynamicbrowser
        @arr_of_routes.each do |route|
            splitted_route = route[1].split("/")
            pp splitted_route

            if splitted_route.length == dynamicbrowser.length
                matchning = true
                pp "#{splitted_route} och #{dynamicbrowser} är lika långa i arrayen"
                splitted_route.each_with_index do |part, index|
                    if part.include?(":")
                        request.params[part] = dynamicbrowser[index]
                        dynamicbrowser[index] = /(\w+)/
                        # require 'debug' 
                        # binding.break
                        pp request.params
                        pp "THIS IS PART #{part}"
                        pp "THIS IS BROWSER #{dynamicbrowser[index]}"
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
