require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/test_rack_app")
require "webrat/rack"

describe Webrat::RackSession do
  before(:each) do
    Webrat.configuration.mode = :rack
    @session = Webrat::RackSession.new(TestRackApp.new)
  end

  describe "#get" do
    it "should work" do
      @session.get("/")
      @session.response_body.should == "got a GET"
    end
  end
end

Webrat.configuration.mode = :rails
