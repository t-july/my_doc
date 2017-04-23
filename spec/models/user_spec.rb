require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    create :user
  end

  it 'subject' do
    expect(subject).to be_a described_class
  end
end
