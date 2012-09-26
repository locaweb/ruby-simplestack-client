module SimpleStack
  class Exception < ::Exception
    def self.factory(error)
      return Exception.new(error.inspect) if !error.is_a?(Hash)
      case error["error"]
      when "EntityNotFound"
        EntityNotFound.new(error["message"])
      when "FeatureNotImplemented"
        NotImplemented.new(error["message"])
      when "FeatureNotAvailable"
        NotImplemented.new(error["message"])
      when "HypervisorError"
        HypervisorError.new(error["message"])
      else
        Exception.new(error.inspect)
      end
    end
  end

  class EntityNotFound < Exception
  end

  class HypervisorError < Exception
  end

  class NotImplemented < Exception
  end

  class GracefulObject
    def [](key)
      GracefulObject.new
    end

    def []=(key, value)
      GracefulObject.new
    end

    def +(other)
      other + self
    end

    def -(other)
      -(other - self)
    end

    def *(other)
      other * self
    end

    def to_i
      0
    end

    def to_f
      0.0
    end

    def to_str
      "GracefulObject"
    end
    alias :to_s :to_str

    def to_ary
      []
    end
    alias :to_a :to_ary

    def to_hash
      {}
    end

    def coerce(other)
      coerced = if other.is_a? Fixnum
        self.to_i
      elsif other.is_a? String
        self.to_s
      elsif other.is_a? Array
        self.to_a
      elsif other.is_a? Hash
        self.to_hash
      else
        nil
      end
      [coerced, other]
    end
  end
end
