class TestRackApp
  DEFAULT_HEADERS = {"Content-Type" => "text/plain"}.freeze

  def call(env)
    request = Rack::Request.new(env)

    case request.request_method
    when "GET"    then make_response("got a GET")
    when "POST"   then make_response("got a POST")
    when "PUT"    then make_response("got a PUT")
    when "DELETE" then make_response("got a DELETE")
    end
  end
    
  private
    def make_response(body, status = 200, headers = {})
      [status, DEFAULT_HEADERS.merge(headers), [body]]
    end
end
