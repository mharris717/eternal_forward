module EternalForward
  class CLI < Thor
    option :pod_port, type: :numeric, default: 80
    option :local_background_port, type: :numeric, default: 5554
    option :local_proxy_port, type: :numeric, default: 5555
    option :namespace
    option :context
    desc "start_proxy APP", "Run the proxy. Namespace and context default to your current defaults if not specified."
    def start_proxy(app)
      ops = {app: app}.merge(options)
      ops.delete('local_proxy_port')
      # raise ops.inspect
      # raise options[:local_proxy_port].inspect
      ForwardProcess.instance = ForwardProcess.new(ops)
      Web.set :port, options[:local_proxy_port]
      Web.run!
    end
  end
end
