module SimpleStack
  class Snapshot < Entity
    def use
      revert
    end

    def revert
      hypervisor.put "#{url}/revert"
    end
  end
end
