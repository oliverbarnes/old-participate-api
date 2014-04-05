class Issue
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :description

  belongs_to :author, class_name: 'Member'
end