$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + "/../../../lib")
require "webrat/sinatra"
require File.expand_path(File.dirname(__FILE__) + "/test_sinatra_app")

describe Webrat::SinatraSession do
  before(:each) do
    Webrat.configuration.mode = :sinatra
    @session = Webrat::SinatraSession.new
  end

  it "should set mode to :sinatra" do
    Webrat.configuration.mode.should == :sinatra
  end

  it "should work" do
    @session.request_page("/", "get", "")
    @session.click_link "there"
    # TODO: use webrat method instead
    @session.response_body.should =~ /form/
  end
end
