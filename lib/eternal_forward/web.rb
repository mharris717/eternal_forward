module EternalForward
  class Web < Sinatra::Base
    enable :logging
    get("/*") do |c|
      ForwardProcess.instance.read c
    end
  end
end
