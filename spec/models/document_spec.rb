require 'rails_helper'

RSpec.describe Document, type: :model do
  subject do
    create :document
  end

  it 'subject' do
    expect(subject).to be_a described_class
  end
end
