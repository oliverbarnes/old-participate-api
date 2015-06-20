require 'rails_helper'

describe 'Proposals API' do
  let(:headers) do
    {
      'Accept':        'application/vnd.api+json',
      'Content-type':  'application/vnd.api+json',
      'Authorization': "Bearer #{token}"
    }
  end
  let!(:login)  { FactoryGirl.create(:login) }
  let(:token)   { login.access_token }
  let(:proposal) { FactoryGirl.create(:proposal) }

  describe 'GET /proposals' do
    let!(:proposals) { [ proposal ] }

    subject { get '/proposals', {}, headers }

    it 'success' do
      subject

      expect(response.status).to eq 200
    end

    it 'collection of proposal resources' do
      subject

      expected = {
        data: [
          {
            id: proposal.id,
            attributes: {
              title: proposal.title,
              body:  proposal.body
            },
            type: 'proposals',
            links: {
              self: "http://www.example.com/proposals/#{proposal.id}"
            }
          }
        ]
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end
  end

  describe 'GET /proposals/:id' do

    subject { get "/proposals/#{proposal.id}", {}, headers }

    it 'success' do
      subject

      expect(response.status).to eq 200
    end

    it 'payment resource' do
      subject

      expected = {
        data: {
          id: proposal.id,
          attributes: {
            title: proposal.title,
            body:  proposal.body
          },
          type: 'proposals',
          links: {
            self: "http://www.example.com/proposals/#{proposal.id}"
          }
        }
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end
  end

  describe 'POST /proposals' do
    let(:params) do
      {
        data: {
          type: 'proposals',
          attributes: {
            title: 'New title',
            body:  'New body'
          }
        }
      }
    end
    let(:new_proposal)  { Proposal.first }

    subject { post '/proposals', params.to_json, headers }

    it 'creates a new proposal from posted attributes' do
      expect(Proposal.count).to eql 0
      subject

      expect(new_proposal.title).to eql params[:data][:attributes][:title]
      expect(new_proposal.body).to eql params[:data][:attributes][:body]
    end

    it '201 created' do
      subject

      expect(response.status).to eq 201
    end
  end

  describe 'PATCH /proposals' do
    let(:params) do
      {
        data: {
          type: 'proposals',
          id: proposal.id,
          attributes: {
            title: 'New title',
            body:  'New body'
          }
        }
      }
    end

    subject { patch "/proposals/#{proposal.id}", params.to_json, headers }

    it "updates proposal's title" do
      expect {
        subject
      }.to change { proposal.reload.title }.from(proposal.title).to(params[:data][:attributes][:title])
    end

    it "updates proposal's body" do
      expect {
        subject
      }.to change { proposal.reload.body }.from(proposal.body).to(params[:data][:attributes][:body])
    end

    it 'success' do
      subject

      expect(response.status).to eq 200
    end

    context "when proposal being patched isn't owned by the current login" do
      let(:another_proposal) { create(:proposal) }

      subject { patch "/proposals/#{another_proposal.id}", params.to_json, headers }

      before { params[:data][:id] = another_proposal.id }

      it 'unauthorized'
    end
  end
end
