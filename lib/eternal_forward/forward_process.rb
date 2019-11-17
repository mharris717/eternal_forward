module EternalForward
  class ForwardProcess
    include FromHash
    attr_accessor :pid
    attr_accessor :app, :pod_port, :local_background_port, :context, :namespace
    # def initialize(app:, pod_port:, local_background_port:, context:)
    #   @app = app
    #   @pod_port = pod_port
    #   @local_background_port = local_background_port
    #   @context = context
    #   @namespace = namespace
    # end

    def cmd
      "kubectl port-forward #{pod} #{local_background_port}:#{pod_port}"
    end


    def pod
      flag_str = lambda do |name|
        val = send(name)
        if val
          "--#{name} #{val}"
        else
          ""
        end
      end
      ec("kubectl get pod -lapp=#{app} -o json #{flag_str[:context]} #{flag_str[:namespace]} | jq -r .items[0].metadata.name").strip
    end

    def start!
      self.pid = spawn(cmd)
      puts "Started #{pid}"
      sleep 1
    end

    def fix_pid!
      self.pid = nil if pid && !running?
    end

    def ensure!
      fix_pid!
      return if pid
      start!
    end

    def running_inner?
      return false unless pid
      process_running? pid
    end

    def running?
      res = running_inner?
      puts "Running? #{res}"
      res
    end

    def read_once(path)
      url = "http://localhost:#{local_background_port}/#{path}"
      puts "Reading #{url}"
      open(url).read
    end

    def restart!
      Process.kill(9, pid) if pid
      sleep 0.5
      start!
    end

    def read(path)
      return "" if path =~ /favicon/
      ensure!
      read_once path
    rescue => exp
      puts "Caught Exception: #{exp.message}"
      restart!
      return read_once path
    end

    class << self
      fattr(:instance) { new }
    end
  end
end
