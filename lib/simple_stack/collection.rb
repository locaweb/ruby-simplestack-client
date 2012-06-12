module SimpleStack
  class Collection
    attr_accessor :url, :clazz

    def initialize(url, clazz)
      self.url = url
      self.clazz = clazz
    end

    def to_a
      @items ||= SimpleStack.client.get(url).map do |item|
        clazz.new "#{url}/#{item["id"]}"
      end
    end

    def find(id)
      clazz.new "#{url}/#{id}"
    end

    def create(options={})
      response = SimpleStack.client.post(url, options)
      clazz.new response.headers["location"]
    end

    def method_missing(method, *args, &block)
      to_a.send(method, *args, &block)
    end

  end
end