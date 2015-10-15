require 'rails_helper'

describe Delegation do
  describe 'validates' do
    subject { FactoryGirl.build(:delegation) }

    it 'presence of a proposal' do
      expect(subject).to be_valid
      subject.proposal = nil
      expect(subject).to_not be_valid
    end

    it 'presence of an author' do
      expect(subject).to be_valid
      subject.author = nil
      expect(subject).to_not be_valid
    end

    it 'presence of an delegate' do
      expect(subject).to be_valid
      subject.delegate = nil
      expect(subject).to_not be_valid
    end
  end
end
