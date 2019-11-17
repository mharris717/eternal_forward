require_relative "eternal_forward/version"

module EternalForward
  class Error < StandardError; end
  # Your code goes here...
end

#!/usr/bin/env ruby

require 'sinatra/base'
require 'open-uri'
require 'thor'
require 'fattr'

require_relative "eternal_forward/util"
require_relative "eternal_forward/cli"
require_relative "eternal_forward/forward_process"
require_relative "eternal_forward/web"
