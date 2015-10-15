require 'rails_helper'

describe Proposal do
  describe '#support_count' do
    subject { FactoryGirl.build(:proposal, :supported) }

    it 'number of associated supports' do
      expect(subject.support_count).to eql 1
    end
  end

  describe 'validates' do
    subject { FactoryGirl.build(:proposal) }

    it 'presence of an author' do
      expect(subject).to be_valid
      subject.author = nil
      expect(subject).to_not be_valid
    end
  end
end
