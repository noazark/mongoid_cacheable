require "active_support"
require "mongoid"
require "mongoid_cacheable/version"

module Mongoid
  module Cacheable
    extend ActiveSupport::Concern

    module ClassMethods
      def cache( name, *options )
        field_name = "_#{name}"
        cached_name = "cached_#{name}"
        clear_cached_name = "clear_cached_#{name}"

        field field_name, *options

        define_method(cached_name) do
          cache_field(field_name, &method(name))
        end

        define_method(clear_cached_name) do
          clear_cache_field(field_name)
        end
      end
    end

    def cache_field(field_name, &block)
      unless read_attribute(field_name)
        # cache quitely with atomic set
        set field_name, yield
      end

      read_attribute(field_name)
    end

    def clear_cache_field(field_name)
      unset field_name
    end
  end
end