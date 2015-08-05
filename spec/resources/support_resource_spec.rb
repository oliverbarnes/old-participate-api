require 'rails_helper'

describe SupportResource do
  describe '.apply_filter' do
    let(:records) { double('a model, actually', where: true) }
    let(:filter)  { double('filter') }
    let(:value)   { 'somevalue' }

    it 'filters with a string value even if this is passed in as an array' do
      expect(records).to receive(:where).with(filter => value)

      described_class.apply_filter(records, filter, [value])
    end

    it 'and filters with a string value when this is passed in as a string as expected' do
      expect(records).to receive(:where).with(filter => value)

      described_class.apply_filter(records, filter, value)
    end
  end
end
