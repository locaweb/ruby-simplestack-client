module SimpleStack
  module Cacheable
    def reload
      @cached_attributes = {}
      self
    end

    def cacheable?
      false
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
