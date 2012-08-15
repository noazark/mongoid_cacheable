class Book
  include Mongoid::Document
  include Mongoid::Cacheable

  field :title

  def title_length
    title.length
  end
  cache :title_length, type: Integer
end