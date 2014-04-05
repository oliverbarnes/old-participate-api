require 'spec_helper'

describe Member do

  describe "#voting_weight" do
    it "is 1 by default" do
      expect( subject.voting_weight ).to eql 1
    end
  end

  describe "#increment_voting_weight!" do
    it "increments voting weight by 1" do
      subject.increment_voting_weight!
      expect( subject.voting_weight ).to eql 2
    end
  end

  describe "#decrement_voting_weight!" do
    it "decrement voting weight by 1" do
      subject.increment_voting_weight!
      expect( subject.voting_weight ).to eql 2
      subject.decrement_voting_weight!
      expect( subject.voting_weight ).to eql 1
    end
  end
  
end