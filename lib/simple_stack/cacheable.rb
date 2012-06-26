module SimpleStack
  module Cacheable
    def reload
      @cached_attributes = {}
      self
    end

    def cacheable?
      if respond_to? :connection
        connection.cache_enabled
      else
        false
      end
    end

    def cached_attributes
      if cacheable?
        @cached_attributes ||= {}
      else
        {}
      end
    end
  end
end
