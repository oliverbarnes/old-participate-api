require 'rails_helper'

class Record
  include Mongoid::Document

  belongs_to :supportable
  belongs_to :author, class_name: 'Participant'
end

class Supportable
  include Mongoid::Document

  belongs_to :author, class_name: 'Participant'
  belongs_to :supports
end

describe SupportedValidator do
  let(:author) { FactoryGirl.build :participant }
  let(:supportable) { Supportable.new(author: author) }
  let(:record)      { Record.new(author: author, supportable: supportable) }

  subject { described_class.new({ attributes: [:something] }) }

  describe '#validates_each' do
    it 'Adds an error for the associated object, stating it needs to be supported' do
      expect {
        subject.validate_each(record, :supportable, supportable)
      }.to change(record.errors, :messages).from({}).to({ supportable: ['must be supported'] })
    end
  end

end
