require 'spec_helper'

describe Vote do

  describe "#weight" do
    it "is 1 by default" do
      expect( subject.weight ).to eql 1
    end

    context "when voter is trusted with another's vote" do
      let(:delegation) { FactoryGirl.create :delegation }
      let(:voter) { delegation.trustee }
      let(:subject) { FactoryGirl.create( :vote, voter: voter ) }

      it "is 2" do
        expect( subject.weight ).to eql 2
      end
    end
  end
  
end