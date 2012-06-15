module SimpleStack
  class Entity
    attr_accessor :hypervisor, :url

    def initialize(hypervisor, url)
      self.hypervisor = hypervisor
      self.url = url.to_s
    end

    def info
      hypervisor.get url
    end

    def update(attributes = {})
      hypervisor.put url, attributes
    end

    def delete
      hypervisor.delete url
    end

    def inspect
      "#<#{self.class} info=#{info.to_json}>"
    end

    def connection
      hypervisor.connection
    end
  end
end
