require 'spec_helper'

describe LiquidFeedback::Issues  do
  before(:each) do
    Issue.destroy_all
  end

  describe 'GET /issues' do
    subject { get '/issues' }

    it 'status 200' do
      subject.status.should == 200
    end

    it 'empty collection' do
      JSON.parse( subject.body ).should == []
    end

    context 'when issues present' do
      before(:each) do
        FactoryGirl.create( :issue, name: 'Kofi' )
      end
  
      it 'status 200' do
        subject.status.should == 200
      end

      it "well-formed json collection" do
        JSON.parse( subject.body ).should == [{'name' => 'Kofi'}]
      end
    end
  end
end