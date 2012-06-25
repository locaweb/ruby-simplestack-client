module SimpleStack
  class Guest < Entity
    def snapshots
      cached_attributes[:snapshots] ||= SimpleStack::Collection.new hypervisor, self, "#{url}/snapshots", SimpleStack::Snapshot
    end

    def reboot(opts={:force => false})
      hypervisor.put "#{url}/reboot", :force => opts[:force]
    end

    def revert_to(snapshot)
      snapshot.revert
    end

    def power_state=(state)
      hypervisor.put "#{url}/power", :state => state
    end

    ["start", "stop", "force_stop", "pause", "resume"].each do |state|
      define_method(state) do
        self.power_state = state
      end
    end
  end
end
