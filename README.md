mongoid_cacheable
=================

Cache Methods in any Mongoid Document.

[![Build Status](https://secure.travis-ci.org/noazark/mongoid_cacheable.png?branch=master)](http://travis-ci.org/noazark/mongoid_cacheable)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/noazark/mongoid_cacheable)

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

user = User.new

user.name = 'John'

# calling the cached method for the first time
user.cached_name_length
  #=> 4

user.name = 'Ron Jon'

# the previous result is still cached
user.cached_name_length
  #=> 4

# access the original method
user.name_length
  #=> 7

# the raw cached field is unchanged
user.read_attribute :_name_length
  #=> 4
```