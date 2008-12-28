$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + "/../../../lib")
require "webrat/sinatra"
require File.expand_path(File.dirname(__FILE__) + "/test_sinatra_app")

describe Webrat::SinatraSession do
  before(:each) do
    Webrat.configuration.mode = :sinatra
    @session = Webrat::SinatraSession.new
  end

  it "should work" do
    @session.request_page("/", "get", "")
    @session.click_link "there"
    @session.fill_in "email", :with => "me@example.org"
    @session.click_button "spam"
    @session.response_body.should contain("hello, me@example.org")
  end
end
