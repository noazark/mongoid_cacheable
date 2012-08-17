require 'spec_helper'

describe Mongoid::Cacheable do

  let(:book) do
    Book.new(title: 'Life')
  end

  let(:fields) do
    Book.fields
  end

  it "caches a method's return" do
    book.cache_field('_abc') { true }
    book.attributes['_abc'].should_not be_nil
  end

  it "does not persist parent prematurely" do
    book.title_length
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