require 'rails_helper'

class Record
  include Mongoid::Document

  belongs_to :supportable
  belongs_to :login
end

class Supportable
  include Mongoid::Document

  belongs_to :login
  belongs_to :supports
end

describe SupportedValidator do
  let(:login)       { FactoryGirl.build :login }
  let(:supportable) { Supportable.new(login: login) }
  let(:record)      { Record.new(login: login, supportable: supportable) }

  subject { described_class.new({ attributes: [:something] }) }

  describe '#validates_each' do
    it 'Adds an error for the associated object, stating it needs to be supported' do
      expect {
        subject.validate_each(record, :supportable, supportable)
      }.to change(record.errors, :messages).from({}).to({ supportable: ['must be supported'] })
    end
  end

end
