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

    def http_options
      {
        :timeout => connection.timeout,
        :read_timeout => connection.read_timeout,
        :no_follow => true,
        :headers => headers
      }
    end

    def token
      Base64.encode64("#{username}:#{password}").split("\n").join("")
    end

    def info
      cached_attributes[:info] ||= self.get url
    end

    def hosts
      cached_attributes[:hosts] ||= SimpleStack::Collection.new self, self, "#{url}/hosts", SimpleStack::Host
    end

    def storages
      cached_attributes[:storages] ||= SimpleStack::Collection.new self, self, "#{url}/storages", SimpleStack::Storage
    end

    def guests
      cached_attributes[:guests] ||= SimpleStack::Collection.new self, self, "#{url}/guests", SimpleStack::Guest
    end

    def import(opts={})
      file = File.open(opts[:from], "rb")

      response = post_stream("#{url}/guests", file)
      entity_path = response["location"].sub(/^\//, "").sub(/\/$/, "")
      entity_url = "#{connection.url}/#{entity_path}"
      SimpleStack::Guest.new self, guests.reload, entity_url
    ensure
      file.close rescue nil
    end

    def get(url)
      http_call { HTTParty.get(url, http_options) }
    end

    def get_stream(url, io)
      uri  = URI.parse url
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.path)

      headers.each_pair do |k, v|
        request.add_field(k, v)
      end

      http.request(request) do |res|
        res.read_body {|chunk| io.write chunk }
      end
    end

    def post(url, body)
      http_call { HTTParty.post(url, http_options.merge(:body => JSON.dump(body))) }
    end

    def put(url, body)
      http_call { HTTParty.put(url, http_options.merge(:body => JSON.dump(body))) }
    end

    def post_stream(url, io)
      uri  = URI.parse url
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path, {})

      headers.each_pair do |k, v|
        request.add_field(k, v)
      end

      request.body_stream = io
      request.content_length = io.size
      response = http.request(request)

      if response.code.to_i >= 400
        parsed_response = JSON.load(response.body) rescue response.body
        raise SimpleStack::Exception.factory(parsed_response)
      end

      response
    end

    def delete(url)
      http_call { HTTParty.delete(url, http_options) }
    end

    def http_call
      response = yield
      return SimpleStack::GracefulObject.new if response.code == 501 && connection.graceful_degradation
      raise SimpleStack::Exception.factory(response.parsed_response) if response.code >= 400
      response
    end

    def inspect
      "#<#{self.class} url=#{url}>"
    end
  end
end
