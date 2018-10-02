# frozen_string_literal: true

require 'rails_helper'

describe BookSuggestion do
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:link) }

  it do
    expect(build(:book_suggestion)).to be_valid
  end

  describe '#create' do
    context 'When the author is nil' do
      it 'is not valid' do
        expect(build(:book_suggestion, author: nil)).not_to be_valid
      end
    end

    context 'When the title is nil' do
      it 'is not valid' do
        expect(build(:book_suggestion, title: nil)).not_to be_valid
      end
    end

    context 'When the link is nil' do
      it 'is not valid' do
        expect(build(:book_suggestion, link: nil)).not_to be_valid
      end
    end
  end
end
