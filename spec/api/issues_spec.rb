require 'spec_helper'

describe LiquidFeedback::Issues  do
  before(:each) do
    Issue.destroy_all
  end

  describe 'GET /issues' do
    subject { get '/issues' }

    it '200' do
      subject.status.should == 200
    end

    it 'empty collection' do
      JSON.parse( subject.body ).should == []
    end

    context 'when issues exist' do
      before(:each) do
        FactoryGirl.create( :issue, name: 'Kofi' )
      end
  
      it '200' do
        subject.status.should == 200
      end

      it "collection of issues" do
        JSON.parse( subject.body ).should == [{'name' => 'Kofi'}]
      end
    end
  end

  describe 'GET /issues/:id' do
    let(:issue) { FactoryGirl.create( :issue ) }
    subject { get "/issues/#{issue.id}" }

    it '200' do
      subject.status.should == 200
    end

    it 'json representation of issue' do
      JSON.parse( subject.body ).should == {'name' => 'Kofi'}
    end

    context 'non-existing id' do
      subject { get "/issues/idontexist" }

      it '404' do
        subject.status.should == 404
      end

      it 'issue not found' do
        JSON.parse( subject.body ).should == {'error' => 'Issue not found'}
      end

    end
  end
end