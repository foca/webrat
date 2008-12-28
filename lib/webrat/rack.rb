require "webrat"
require "rack"

class CGIMethods #:nodoc:
  def self.parse_query_parameters(params)
    hash = {}
    params.split('&').each do |p|
      pair = p.split('=')
      hash[pair[0]] = pair[1]
    end
    hash
  end
end

module Webrat
  class RackSession < Session #:nodoc:
    attr_reader :response, :request
    attr_accessor :app

    def get(path, data={}, headers={})
      do_request(:get, path, data, headers)
    end

    def post(path, data={}, headers={})
      do_request(:post, path, data, headers)
    end

    def put(path, data={}, headers={})
      do_request(:put, path, data, headers)
    end

    def delete(path, data={}, headers={})
      do_request(:delete, path, data, headers)
    end

    def response_body
      @response.body
    end

    def response_code
      @response.status
    end

    private
      def do_request(verb, path, data={}, headers={})
        if data.is_a?(String)
          headers.update(:input => data)
          data = {}
        end

        @request = Rack::MockRequest.new(app)
        @response = request.send(verb, uri(path, data), headers)
        follow_redirect while @response.redirect?
      end

      def follow_redirect
        @response = request_page(@response.location, :get, {})
      end

      def uri(path, data={})
        uri = URI(path)
        uri.query = data.map {|k,v| "#{k}=#{v}" }.join("&")
        uri.to_s
      end
  end
end
