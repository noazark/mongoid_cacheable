class Cache
  include Mongoid::Document
  embedded_in :cacheable, polymorphic: true
end