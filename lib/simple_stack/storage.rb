module SimpleStack
  class Storage < Entity
    def import(opts={})
      file = File.open(opts[:from], "rb")

      response = hypervisor.post_stream("#{url}/guests", file)
      entity_path = response["location"].sub(/^\//, "").sub(/\/$/, "")
      entity_url = "#{connection.url}/#{entity_path}"
      SimpleStack::Guest.new hypervisor, hypervisor.guests.reload, entity_url
    ensure
      file.close rescue nil
    end
  end
end
