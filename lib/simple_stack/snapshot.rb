module SimpleStack
  class Snapshot < Entity
    def use
      revert
    end

    def revert
      raise "Not Implemented"
    end
  end
end
