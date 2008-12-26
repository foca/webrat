class TestRackApp

  def call(env)
    if env["rack.input"]
      input = env["rack.input"].dup
      input.rewind
      env["rack.input"] = input.read
    end

    [200, {"Content-Type" => "text/plain"}, [
      env.to_yaml
    ]]
  end
end
