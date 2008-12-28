require File.expand_path(File.dirname(__FILE__) + '/helper')

describe Webrat::SinatraSession do
  before(:each) do
    Webrat.configuration.mode == :sinatra
    @session = Webrat::SinatraSession.new
  end

  it "should work" do
    @session.get "/"
    @session.response_body.should == "Hello World"
  end
end
