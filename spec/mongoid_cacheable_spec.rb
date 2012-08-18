require 'spec_helper'

class Book
  include Mongoid::Document
  include Mongoid::Cacheable

  def say
    true
  end
end

describe Mongoid::Cacheable do

  let(:book) { Book.new }

  before :each do
    book.cache_field(:_abc) { true }
  end

  it "caches a method's result" do
    book.read_attribute(:_abc).should_not be_nil
  end

  it "clears a cache result" do
    book.clear_cache_field(:_abc)
    book.read_attribute(:_abc).should be_nil
  end

  it "caches wihtout saving the parent" do
    book.new_record?.should be_true
  end

  it "cache is persistant" do
    book.save
    book.reload.cache_field(:_abc).should_not be_nil
  end

  context "when a method is cached" do

    before :each do
      book.class.cache :say
      book.cache_field(:_say) { 'message' }
    end
  
    it "creates a cached method alias" do
      book.cached_say.should eq 'message'
    end

    it "original method remains uncached" do
      book.say.should eq true
    end
  
    it "creates a clear cached method alias" do
      book.clear_cached_say
      book.cached_say.should eq true
    end
    
  end

end