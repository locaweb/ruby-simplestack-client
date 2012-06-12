module SimpleStack
  class Guest < Entity
    def snapshots
      SimpleStack::Collection.new "#{url}/snapshots", SimpleStack::Snapshot
    end

    def reboot
      SimpleStack.client.put "#{url}/reboot"
    end

    def power_state=(state)
      SimpleStack.client.put "#{url}/power", :state => state
    end

    ["start", "stop", "force_stop", "pause", "resume"].each do |state|
      define_method(state) do
        self.power_state = state
      end
    end
  end
end
