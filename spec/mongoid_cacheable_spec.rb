require 'spec_helper'

describe Mongoid::Cacheable do

  let(:book) { Book.new(title: 'abcd') }

  context "when uncached" do

    it "caches method result" do
      book.title_length
      book.cached_title_length.should eq 4
    end
    
    describe '#cached' do

      it 'returns directly from cache' do
        book.cached_title_length.should eq nil
      end

    end

  end

  context "when previously cached" do

    before do
      book._title_length = 17
    end

    it 'returns directly from cache' do
      book.title_length.should eq 17
    end
  
    describe '#cached' do

      it 'returns directly from cache' do
        book.cached_title_length.should eq 17
      end

    end
  
    describe '#uncached' do

      it 'ignore cached value and return caclulated value' do
        book.uncached_title_length.should eq 4
      end

    end

  end

end