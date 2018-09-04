require 'rails_helper'

describe Rent do
  it { should validate_presence_of(:loan) }
  it { should validate_presence_of(:restitution) }

  it do
    expect(build(:rent)).to be_valid
  end
end
