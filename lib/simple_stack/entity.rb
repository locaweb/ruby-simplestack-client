module SimpleStack
  class Entity
    attr_accessor :url

    def initialize(connection, url)
      self.connection = connection
    end

    def info
      connection.get url
    end

    def update(attributes = {})
      connection.put url, attributes
    end

    def delete
      connection.delete url
    end
  end
end
