require 'spec_helper'

describe Delegation do
  let(:subject) { FactoryGirl.build :delegation }

  describe "when created" do
    it "increments trustee voting weight" do
      expect( subject.trustee ).to receive(:increment_voting_weight!)
      subject.save
    end
  end

  describe "when destroyed" do
    it "decrements trustee voting weight" do
      subject.save
      expect( subject.trustee ).to receive(:decrement_voting_weight!)
      subject.destroy
    end
  end
  
end