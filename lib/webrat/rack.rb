require "webrat"
require "pp"
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
    attr_reader :response
    attr_accessor :app

    def get(path, data={}, headers={})
      do_request("GET", path, data, headers)
    end

    def post(path, data={}, headers={})
      do_request("POST", path, data, headers)
    end

    def put(path, data={}, headers={})
      do_request("PUT", path, data, headers)
    end

    def delete(path, data={}, headers={})
      do_request("DELETE", path, data, headers)
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
        
        @response = request.request(verb, path, Rack::MockRequest.env_for(uri(path, data), headers))
        @response = request_page(@response.location, :get, {}) if @response.redirect?
      end
      
      def request
        Rack::MockRequest.new(app)
      end
      
      def uri(path, data={})
        uri          = URI(path)
        uri.scheme ||= "http"
        uri.host   ||= "example.org"
        uri.query    = Rack::Utils.build_query(data)
        uri.to_s
      end
    end
end
