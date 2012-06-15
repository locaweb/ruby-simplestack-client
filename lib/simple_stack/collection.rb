module SimpleStack
  class Collection
    attr_accessor :hypervisor, :url, :clazz

    def initialize(hypervisor, url, clazz)
      self.hypervisor = hypervisor
      self.url = url.to_s
      self.clazz = clazz
    end

    def to_a
      @items = hypervisor.get(url).map do |item|
        clazz.new hypervisor, "#{url}/#{item["id"]}"
      end
    end

    def find(id)
      clazz.new hypervisor, "#{url}/#{id}"
    end

    def create(options={})
      response = hypervisor.post(url, options)
      entity_path = response.headers["location"].sub(/^\//, "").sub(/\/$/, "")
      entity_url = "#{connection.url}/#{entity_path}"
      clazz.new hypervisor, entity_url
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