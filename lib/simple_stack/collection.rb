module SimpleStack
  class Collection
    attr_accessor :connection, :url, :clazz

    def initialize(connection, url, clazz)
      self.connection = connection
      self.url = url
      self.clazz = clazz
    end

    def to_a
      @items = connection.get(url).map do |item|
        clazz.new connection, "#{url}/#{item["id"]}"
      end
    end

    def find(id)
      clazz.new connection, "#{url}/#{id}"
    end

    def create(options={})
      response = connection.post(url, options)
      clazz.new connection, response.headers["location"]
    end

    def method_missing(method, *args, &block)
      to_a.send(method, *args, &block)
    end

  end
end