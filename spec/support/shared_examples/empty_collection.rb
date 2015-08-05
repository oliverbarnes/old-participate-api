require 'spec_helper'

shared_examples 'empty collection' do
  it '200 OK' do
    subject

    expect(response.status).to eq 200
  end

  it 'empty array' do
    subject

    expected = { data: [] }.to_json
    expect(response.body).to be_json_eql(expected)
  end
end
