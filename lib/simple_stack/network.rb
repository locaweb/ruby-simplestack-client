module SimpleStack
  class Network < Entity
    def networks
      cached_attributes[:networks] ||= SimpleStack::Collection.new hypervisor, self, "#{url}/networks", SimpleStack::Network
    end

  end
end
