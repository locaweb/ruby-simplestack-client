module SimpleStack
  class Collection
    include SimpleStack::Cacheable

    attr_accessor :hypervisor, :parent, :url, :clazz

    def initialize(hypervisor, parent, url, clazz)
      self.hypervisor = hypervisor
      self.parent = parent
      self.url = url.to_s
      self.clazz = clazz
    end

    def to_a
      cached_attributes[:items] ||= hypervisor.get(url).map do |item|
        clazz.new hypervisor, self, "#{url}/#{item["id"]}"
      end
    end

    def find(id)
      clazz.new hypervisor, self, "#{url}/#{id}"
    end

    def create(options={})
      response = hypervisor.post(url, options)
      entity_path = response.headers["location"].sub(/^\//, "").sub(/\/$/, "")
      entity_url = "#{connection.url}/#{entity_path}"
      new_item = clazz.new hypervisor, self, entity_url
      reload if cacheable?
      new_item
    end

    def method_missing(method, *args, &block)
      to_a.send(method, *args, &block)
    end

    def inspect
      to_a.inspect
    end

    def connection
      hypervisor.connection
    end
  end
end
