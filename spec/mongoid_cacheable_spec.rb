require 'spec_helper'

describe Mongoid::Cacheable do

  let(:book) do
    Book.new(title: 'Life')
  end

  let(:fields) do
    Book.fields
  end

  it "adds a cached field to the document" do
    fields['_title_length'].should_not be_nil
  end

  context "when uncached" do

    it "caches method result" do
      book.title_length
      book.cached_title_length.should eq 4
    end

  end

  context "when previously cached" do

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