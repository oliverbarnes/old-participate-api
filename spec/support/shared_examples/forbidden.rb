require 'spec_helper'

shared_examples "token doesn't belong to owner" do
  it '403 Forbidden' do
    subject

    expect(response.status).to eq 403
  end

  it 'responds with an empty body' do
    subject

    expect(response.body).to eq ''
  end

end
