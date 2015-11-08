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

  describe '#weight' do
    subject { FactoryGirl.create(:support, :with_double_weight) }

    before do
      # couldn't get factory to do this :P
      delegation = subject.author.delegations_received.first
      delegation.proposal = subject.proposal
      delegation.save!
    end

    it "returns the sum of a supporter's delegations and her own support" do
      expect(subject.weight).to eql 2
      FactoryGirl.create(
        :delegation,
        delegate: subject.author,
        proposal: subject.proposal
      )
      subject.reload
      expect(subject.weight).to eql 3
    end
  end
end
