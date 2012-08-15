mongoid_cacheable
=================

Cache Methods in any Mongoid Document.

## Getting Started

```ruby
require 'mongoid'
require 'mongoid_cacheable'

class User
  include Mongoid::Document
  include Mongoid::Cacheable

  field :name
  cache :characters_in_name, type: Integer

  def characters_in_name
    name.length
  end
end

user = User.new(name: 'John')

user.attributes[:characters_in_name]
  #=> nil

user.characters_in_name
  #=> 4

user.attributes[:characters_in_name]
  #=> 4
```