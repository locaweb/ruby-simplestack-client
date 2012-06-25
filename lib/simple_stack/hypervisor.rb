module SimpleStack
  class Hypervisor
    include SimpleStack::Cacheable

    attr_accessor :connection, :type, :host, :username, :password

    def initialize(connection, type, options)
      self.connection = connection
      self.type = type
      self.host = options[:host]
      self.username = options[:username]
      self.password = options[:password]
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
      Base64.encode64("#{username}:#{password}").split("\n").join("")
    end

    def info
      cached_attributes[:info] ||= self.get url
    end

    def guests
      cached_attributes[:guests] ||= SimpleStack::Collection.new self, self, "#{url}/guests", SimpleStack::Guest
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
