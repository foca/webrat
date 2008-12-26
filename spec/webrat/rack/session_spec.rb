require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/test_rack_app")
require "webrat/rack"

describe Webrat::RackSession do
  before(:each) do
    @session = Webrat::RackSession.new(TestRackApp.new)
  end

  it "should set mode to rack" do
    Webrat.configuration.mode.should == :rack
  end

  describe "#get" do
    it "should work" do
      @session.get("/")
      @session.response_body.should == "got a GET"
    end
  end
end

Webrat.configuration.mode = :rails
