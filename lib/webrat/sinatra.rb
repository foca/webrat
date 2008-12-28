require 'webrat/rack'
require 'sinatra'

disable :run
disable :reload

module Webrat
  class SinatraSession < RackSession #:nodoc:
    def initialize(app=Sinatra.build_application)
      @app = app
    end
  end
end
