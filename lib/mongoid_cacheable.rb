require "active_support"
require "mongoid"
require "mongoid_cacheable/cache"
require "mongoid_cacheable/version"

module Mongoid
  module Cacheable
    extend ActiveSupport::Concern

    included do
      after_initialize -> { build_cached unless cached }
      embeds_one :cached, as: :cacheable, class_name: "Cache"
    end

    module ClassMethods
      def cache( name, *options )
        field_name = "_#{name}"
        cached_name = "cached_#{name}"
        clear_cached_name = "clear_cached_#{name}"

        define_method(cached_name) do
          cache_field(field_name, &method(name))
        end

        define_method(clear_cached_name) do
          clear_cache_field(field_name)
        end
      end
    end

    def cache_field(field_name, &block)
      unless cached.read_attribute(field_name)
        # cache quitely with atomic set
        cached.set field_name, yield
      end

      cached.read_attribute(field_name)
    end

    def clear_cache_field(field_name)
      cached.unset field_name
    end
  end
end