# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/request'

# describe 'Request' do
#   describe 'Simple get-request' do
#     it 'parses the http method' do
#       request_string = File.read('./test/example_requests/get-index.request.txt')
#       request = Request.new(request_string)
#       _(request.method).must_equal :get
#     end

#     it 'parses the resource' do
#       request_string = File.read('./test/example_requests/get-index.request.txt')
#       request = Request.new(request_string)
#       _(request.resource).must_equal '/'
#     end
#   end
# end

describe 'Request' do
  describe 'Get-examples' do
    before do
      @request = Request.new(File.read("test/example_requests/get-examples.request.txt"))
    end
    
    it 'method' do
      assert_equal :get, @request.method
    end

    it 'resource' do
      assert_equal "/examples", @request.resource
    end

    it 'version' do
      assert_equal "HTTP/1.1", @request.version
    end

    it 'header' do
      assert_equal ({"Host"=>"example.com", "User-Agent"=>"ExampleBrowser/1.0", "Accept-Encoding"=>"gzip, deflate", "Accept"=>"*/*"}), @request.headers
    end

    it 'param' do
      assert_equal ({}), @request.params
    end

  end

  describe 'Get-fruits' do
    before do
      @request = Request.new(File.read("test/example_requests/get-fruits-with-filter.request.txt"))
    end
    
    it 'method' do
      assert_equal :get, @request.method
    end

    it 'resource' do
      assert_equal "/fruits", @request.resource
    end

    it 'version' do
      assert_equal "HTTP/1.1", @request.version
    end

    it 'header' do
      assert_equal ({"Host"=>"fruits.com", "User-Agent"=>"ExampleBrowser/1.0", "Accept-Encoding"=>"gzip, deflate", "Accept"=>"*/*"}), @request.headers
    end

    it 'param' do
      assert_equal ({"type"=>"bananas", "minrating"=>"4"}), @request.params
    end

  end
      
end



