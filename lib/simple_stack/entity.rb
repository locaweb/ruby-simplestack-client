module SimpleStack
  class Entity
    include SimpleStack::Cacheable

    attr_accessor :hypervisor, :parent, :url

    def initialize(hypervisor, parent, url)
      self.hypervisor = hypervisor
      self.parent = parent
      self.url = url.to_s
    end

    def info
      cached_attributes[:info] ||= hypervisor.get(url).parsed_response
    end

    def update(attributes = {})
      hypervisor.put url, attributes
    end

    def delete
      response = hypervisor.delete url
      if cacheable?
        parent.cached_attributes[:items] ||= []
        parent.cached_attributes[:items].delete self
      end
      response
    end

    def inspect
      "#<#{self.class} info=#{info.to_json}>"
    end

    def connection
      hypervisor.connection
    end

    def method_missing(method, *args, &block)
      entity_info = info
      if entity_info.keys.include?(method.to_s)
        entity_info[method.to_s]
      else
        super
      end
    end
  end
end
