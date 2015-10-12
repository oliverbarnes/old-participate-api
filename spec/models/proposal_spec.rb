require 'rails_helper'

describe Proposal do
  describe '#support_count' do
    subject { FactoryGirl.build(:proposal, :supported) }

    it 'number of associated supports' do
      expect(subject.support_count).to eql 1
    end
  end
end
