require 'rails_helper'

describe Support do
  describe 'validates' do
    subject { FactoryGirl.build(:support) }

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
  end
end
