require 'webrat/rack'
require 'sinatra'

disable :run
disable :reload

module Webrat
  class SinatraSession < RackSession #:nodoc:
    def app
      @app ||= Sinatra.application
    end
  end
end
