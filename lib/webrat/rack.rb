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
    def initialize(app)
      @request = Rack::MockRequest.new(app)
    end

    def get(path, *args)
      @response = do_request("GET", path, *args)
    end

    def response_body
      @response.body
    end

    def response_code
      @response.status
    end

    private
      def do_request(verb, path, data = nil, headers = nil)
        uri         = URI(path)
        uri.scheme  = "http"
        uri.host    = "example.org"

        case data
        when Hash
          env = data.delete(:env) || {}
          uri.query = Rack::Utils.build_query(data)
          @request.request(verb, path, Rack::MockRequest.env_for(uri.to_s, env))
        when String
          if headers
            env = headers.delete(:env) || {}
            uri.query = Rack::Utils.build_query(headers)
          end
          options = {:input => data.to_s}
          options.merge!(env) if env
          @request.request(verb, path, Rack::MockRequest.env_for(uri.to_s, options))
        else
          @request.request(verb, path, {})
        end
      end
    end
end
