# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/request'

describe 'Request' do
  describe 'Simple get-request' do
    it 'parses the http method' do
      request_string = File.read('./test/example_requests/get-index.request.txt')
      request = Request.new(request_string)
      _(request.method).must_equal :get
    end

    it 'parses the resource' do
      request_string = File.read('./test/example_requests/get-index.request.txt')
      request = Request.new(request_string)
      _(request.resource).must_equal '/'
    end
  end
end
