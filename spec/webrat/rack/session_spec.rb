require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/test_rack_app")
require "webrat/rack"

describe Webrat::RackSession do
  before(:each) do
    Webrat.configuration.mode = :rack
    @session = Webrat::RackSession.new(TestRackApp.new)
  end

  def request
    Rack::Request.new(YAML.load(@session.response_body))
  end

  describe "#get" do
    it "should work" do
      @session.get("/")

      @session.response_code.should == 200
      request.should be_get
      request.body.should be_empty
    end

    it "should work with params" do
      @session.get("/", :foo => "bar")

      @session.response_code.should == 200
      request.should be_get
      request.GET.should == {"foo" => "bar"}
      request.body.should be_empty
    end

    it "should work with a body" do
      @session.get("/", "foobar")

      request.should be_get
      request.body.should == "foobar"
    end

    it "should work with a body and params" do
      @session.get("/", "foobar", :q => "spam", :x => :y)

      @session.response_code.should == 200
      request.should be_get
      request.body.should == "foobar"
      request.GET.should == {"q" => "spam", "x" => "y"}
    end
  end
end
