require "active_support"
require "mongoid"
require "mongoid_cacheable/version"

module Mongoid
  module Cacheable
    extend ActiveSupport::Concern

    module ClassMethods
      def cache( name, *options )
        field_name = "_#{name}"
        uncached_name = "uncached_#{name}"
        cached_name = "cached_#{name}"

        field field_name, *options

        alias_method uncached_name, name
        alias_method cached_name, field_name

        define_method(name) do
          unless attributes[field_name]
            # cache quitely with atomic set
            set field_name, send(uncached_name)
          end

          attributes[field_name]
        end
      end
    end
  end
end