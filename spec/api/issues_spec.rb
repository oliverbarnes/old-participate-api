require 'spec_helper'

describe LiquidFeedback::Issues  do
  before(:each) do
    Issue.destroy_all
  end

  describe 'GET /issues' do
    it 'status 200' do
      get '/issues'
      last_response.status.should == 200
    end

    it 'empty collection' do
      get '/issues'
      JSON.parse( last_response.body ).should == []
    end

    context 'when issues present' do
      before(:each) do
        FactoryGirl.create( :issue, name: 'Kofi' )
      end
  
      it 'status 200' do
        get '/issues'
        last_response.status.should == 200
      end

      it "well-formed json collection" do
        get '/issues'
        last_response.status.should == 200
        JSON.parse( last_response.body ).should == [{'name' => 'Kofi'}]
      end
    end
  end
end