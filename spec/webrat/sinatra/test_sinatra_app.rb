require "sinatra"

class Sinatra::Application
  def self.load_default_options_from_command_line!
  end
end

disable :reload

use_in_file_templates!

get "/" do
  erb :home
end

get "/go" do
  erb :go
end

post "/go" do
  @user = params[:email]
  erb :hello
end

use_in_file_templates!
__END__
@@ layout
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <title>sinatra testing with webrat</title>
  <body>
    <%= yield %>
  </body>
</html>

@@ home
<p> visit <a href="/go">there</a></p>

@@ go
<form method="post" action="/go">
  <input type="text" name="email" id="email">
  <input type="submit" name="spam" value="spam mea, please!" />
</form>

@@ hello
<p>hello, <%= @user %></p>

