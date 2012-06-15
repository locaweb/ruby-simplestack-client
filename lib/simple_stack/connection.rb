module SimpleStack
  class Connection
    attr_accessor :url

    def initialize(options = {})
      self.url = options[:url].to_s.sub(/\/$/, "")
    end

    def connect_to(type, options)
      SimpleStack::Hypervisor.new self, type, options
    end

    def token
      "TODO"
    end
  end
end