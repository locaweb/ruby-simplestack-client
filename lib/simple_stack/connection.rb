module SimpleStack
  class Connection
    attr_accessor :url, :graceful_degradation

    def initialize(options = {})
      self.url = options[:url].to_s.sub(/\/$/, "")
      self.graceful_degradation = options[:graceful_degradation]
    end

    def connect_to(type, options)
      SimpleStack::Hypervisor.new self, type, options
    end

    def token
      "TODO"
    end
  end
end