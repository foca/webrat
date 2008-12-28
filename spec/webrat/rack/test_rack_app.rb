class TestRackApp
  class FakeStringIO
    def initialize(string)
      @string = string
    end
    def rewind; end
    def read; @string; end
  end

  def call(env)
    [200, {"Content-Type" => "text/plain"}, [
      env.tap do |env|
        if input = env["rack.input"]
          env["rack.input"] = FakeStringIO.new(input.read)
        end
      end.to_yaml
    ]]
  end
end
