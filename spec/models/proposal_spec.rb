require 'rails_helper'

describe Proposal do
  describe '#support_count' do
    subject { FactoryGirl.build(:proposal, :supported) }

    it 'sum of support weights' do
      expect(subject.support_count).to eql 1
      FactoryGirl.create(
        :delegation,
        proposal: subject,
        delegate: subject.supports.first.author
      )
      expect(subject.support_count).to eql 2
    end

    context 'when not supported' do
      it '0' do
        subject.supports = nil
        expect(subject.support_count).to eql 0
      end
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
