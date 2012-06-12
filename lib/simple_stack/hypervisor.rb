module SimpleStack
  class Hypervisor
    attr_accessor :main_url, :type, :host

    def initialize(main_url, type, options)
      self.main_url = main_url
      self.type = type
      self.host = options[:host]
    end

    def url
      "#{main_url}/#{type}/#{host}"
    end

    def info
      SimpleStack.client.get url
    end

    def guests
      Simplestack::Collection.new "#{url}/guests", Simplestack::Guest
    end
  end
end
