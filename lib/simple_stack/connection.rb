module SimpleStack
  class Connection
    attr_accessor :url, :graceful_degradation, :cache_enabled

    def initialize(options = {})
      self.url = options[:url].to_s.sub(/\/$/, "")
      self.graceful_degradation = options[:graceful_degradation]
      self.cache_enabled = options[:cache_enabled]
    end

    def connect_to(type, options)
      SimpleStack::Hypervisor.new self, type, options
    end

    def token
      "TODO"
    end
  end
end