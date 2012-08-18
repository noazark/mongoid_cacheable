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

  context "when a method is uncached" do

    it "caches method result" do
      book.title_length
      book.cached_title_length.should eq 4
    end

  end

  context "when a method has been previously cached" do

    before do
      book._title_length = 17
    end

    it 'returns directly from cache' do
      book.title_length.should eq 17
    end

    it 'returns the uncached result' do
      book.uncached_title_length.should eq 4
    end

  end

end