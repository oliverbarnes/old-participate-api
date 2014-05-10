class Initiative
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :description

  belongs_to :author, class_name: 'Member'
  belongs_to :area
  belongs_to :issue
end