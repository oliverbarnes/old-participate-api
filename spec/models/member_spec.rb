require 'spec_helper'

describe Member do

  describe "#voting_weight" do
    it "is 1 by default" do
      expect( subject.voting_weight ).to eql 1
    end

    context "when member is trusted with another's vote" do
      let(:delegation) { FactoryGirl.create :delegation }
      let(:subject) { delegation.trustee }

      it "is incremented by 1" do
        expect( subject.voting_weight ).to eql 2
      end
    end

    context "when another member's previous vote delegation to this member is removed" do
      let(:delegation) { FactoryGirl.create :delegation }
      let(:subject) { delegation.trustee }

      it "is decremented by 1" do
        expect( subject.voting_weight ).to eql 2
        delegation.destroy
        expect( subject.voting_weight ).to eql 1
      end
    end
  end
  
end