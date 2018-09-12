# frozen_string_literal: true

require 'rails_helper'

describe Book do
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:publisher) }
  it { should validate_presence_of(:year) }

  it do
    expect(build(:book)).to be_valid
  end

  describe '#create' do
    context 'When the genre is nil' do
      it 'is not valid' do
        expect(build(:book, genre: nil)).not_to be_valid
      end
    end

    context 'When the author is nil' do
      it 'is not valid' do
        expect(build(:book, author: nil)).not_to be_valid
      end
    end

    context 'When the image is nil' do
      it 'is not valid' do
        expect(build(:book, image: nil)).not_to be_valid
      end
    end

    context 'When the title is nil' do
      it 'is not valid' do
        expect(build(:book, title: nil)).not_to be_valid
      end
    end

    context 'When the publisher is nil' do
      it 'is not valid' do
        expect(build(:book, publisher: nil)).not_to be_valid
      end
    end

    context 'When the year is nil' do
      it 'is not valid' do
        expect(build(:book, year: nil)).not_to be_valid
      end
    end
  end
end
