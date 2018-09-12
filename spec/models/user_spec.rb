# frozen_string_literal: true

require 'rails_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it do
    expect(build(:user)).to be_valid
  end

  describe '#create' do
    context 'When the first_name is nil' do
      it 'is not valid' do
        expect(build(:user, first_name: nil)).not_to be_valid
      end
    end

    context 'When the last_name is nil' do
      it 'is not valid' do
        expect(build(:user, last_name: nil)).not_to be_valid
      end
    end
  end
end
