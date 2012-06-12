module SimpleStack
  class Connection
    attr_accessor :url

    def initialize(options = {})
      self.url = options[:url]
    end

    def connect_to(type, options)
      Simplestack::Hypervisor.new url, type, options
    end
  end
end