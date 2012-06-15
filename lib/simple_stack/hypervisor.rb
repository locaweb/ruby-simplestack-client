module SimpleStack
  class Hypervisor
    attr_accessor :connection, :type, :host

    def initialize(connection, type, options)
      self.connection = connection
      self.type = type
      self.host = options[:host]
    end

    def url
      "#{connection.url}/#{type}/#{host}"
    end

    def headers
      {
        "x-simplestack-version" => "1.0",
        "x-simplestack-token"   => connection.token,
        "x-simplestack-hypervisor-token" => token,
        "Content-Type" => "application/json"
      }
    end

    def token
      "TODO"
    end

    def info
      self.get url
    end

    def guests
      SimpleStack::Collection.new self, "#{url}/guests", SimpleStack::Guest
    end

    def get(url)
      HTTParty.get(url, :headers => headers, :no_follow => true)
    end

    def post(url, body)
      HTTParty.post(url, :body => JSON.dump(body), :headers => headers, :no_follow => true)
    end

    def put(url, body)
      HTTParty.put(url, :body => JSON.dump(body), :headers => headers, :no_follow => true)
    end

    def delete(url)
      HTTParty.delete(url, :headers => headers, :no_follow => true)
    end

    def inspect
      "#<#{self.class} url=#{url}>"
    end
  end
end
