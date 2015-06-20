require 'spec_helper'

shared_examples 'token is invalid' do
  let(:token) { 'badtoken' }

  it '401 Unauthorized' do
    subject

    expect(response.status).to eq 401
  end

  it 'empty body' do
    subject

    expect(response.body).to eq ''
  end

end
