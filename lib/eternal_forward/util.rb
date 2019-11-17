def process_running?(pid)
  raise 'foo' unless pid
  begin
    res = Process.kill 0, pid
    true
  rescue
    return false
  end
end

def ec(cmd,ops={})
  puts cmd unless ops[:silent]
  res = `#{cmd}`

  raise "bad cmd #{$?.to_i} #{cmd} #{res}" unless $?.to_i == 0
  puts res unless ops[:silent]
  res
end

module FromHash
  def from_hash(ops)
    ops.each do |k,v|
      send("#{k}=",v)
    end
    self
  end
  def initialize(ops={})
    from_hash(ops)
  end
end
