require 'webrat/rack'

module Webrat
  class SinatraSession < RackSession #:nodoc:
    def app
      @app ||= Sinatra.application
    end
  end
end
