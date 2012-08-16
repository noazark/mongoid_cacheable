mongoid_cacheable
=================

Cache Methods in any Mongoid Document.

[![Build Status](https://secure.travis-ci.org/noazark/mongoid_cacheable.png?branch=master)](http://travis-ci.org/noazark/mongoid_cacheable)

## Getting Started

```ruby
require 'mongoid'
require 'mongoid_cacheable'

class User
  include Mongoid::Document
  include Mongoid::Cacheable

  field :name

  def name_length
    name.length
  end
  cache :name_length, type: Integer
end

user = User.new(name: 'John')

user.attributes['_name_length']
  #=> nil

user.name_length
  #=> 4

user.attributes['_name_length']
  #=> 4
```