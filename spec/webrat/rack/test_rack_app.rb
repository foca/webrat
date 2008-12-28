class TestRackApp
  class FakeStringIO
    def initialize(string)
      @string = string
    end
    def rewind; end
    def read; @string; end
  end

  def call(env)
    if input = env["rack.input"]
      env["rack.input"] = FakeStringIO.new(input.read)
    end
    [200, {"Content-Type" => "text/plain"}, [env.to_yaml]]
  end
end
