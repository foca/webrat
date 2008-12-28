class TestRackApp

  def call(env)
    [200, {"Content-Type" => "text/plain"}, [
      env.tap do |env|
        if input = env["rack.input"]
          input.rewind
          env["rack.input"] = input.read
        end
      end.to_yaml
    ]]
  end
end
