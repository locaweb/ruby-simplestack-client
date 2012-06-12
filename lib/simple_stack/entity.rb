module SimpleStack
  class Entity
    attr_accessor :url

    def initialize(url)
      self.url = url
    end

    def info
      SimpleStack.client.get url
    end

    def update(attributes = {})
      SimpleStack.client.put url, attributes
    end

    def delete
      SimpleStack.client.delete url
    end
  end
end
