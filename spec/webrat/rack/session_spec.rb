require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/test_rack_app")
require "webrat/rack"

describe Webrat::RackSession do
  before(:each) do
    Webrat.configuration.mode = :rack
    @session = Webrat::RackSession.new
    @session.app = TestRackApp.new
  end

  def request
    Rack::Request.new(YAML.load(@session.response_body))
  end

  describe "#get" do
    it "should work" do
      @session.request_page("/", "get", {})

      @session.response_code.should == 200
      request.should be_get
      request.GET.should be_empty
      request.body.should be_empty
    end

    it "should work with params" do
      @session.request_page("/", "get", :foo => "bar")

      @session.response_code.should == 200
      request.should be_get
      request.GET.should == {"foo" => "bar"}
      request.body.should be_empty
    end

    it "should work with a body" do
      @session.request_page("/", "get", "foobar")

      request.should be_get
      request.body.should == "foobar"
      request.GET.should be_empty
    end

    it "should work with a body and params" do
      pending "fix me" do
        @session.get("/", "foobar", :q => "spam", :x => :y)

        @session.response_code.should == 200
        request.should be_get
        request.body.should == "foobar"
        request.GET.should == {"q" => "spam", "x" => "y"}
      end
    end

    it "should be possible to specify env" do
      header "Accept", "text/plain"
      @session.request_page("/", "get", {})

      @session.response_code.should == 200
      request.should be_get
      request.env["Accept"].should == "text/plain"
      request.body.should be_empty
      # TODO: request.params.should be_empty fail
      request.GET.should be_empty
    end

    it "should be possible to specify env alongs with a body" do
      header "Accept", "text/plain"
      @session.request_page("/", "get", "foobar")

      @session.response_code.should == 200
      request.should be_get
      request.env["Accept"].should == "text/plain"
      request.body.should == "foobar"
      request.GET.should be_empty
    end

    it "should be possible to specify env alongs with params" do
      header "Accept", "text/plain"
      @session.request_page("/", "get", :foo => "bar")

      @session.response_code.should == 200
      request.should be_get
      request.env["Accept"].should == "text/plain"
      request.GET.should == {"foo" => "bar"}
      request.body.should be_empty
    end

    it "should be possible to specify env alongs with both params and body" do
      pending "fix me" do
        @session.get("/", "a body", :foo => "bar", :env => {"Accept" => "text/plain"})

        @session.response_code.should == 200
        request.should be_get
        request.env["Accept"].should == "text/plain"
        request.GET.should == {"foo" => "bar"}
        request.body.should == "a body"
      end
    end
  end
end
