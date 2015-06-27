class Support
  include Mongoid::Document

  belongs_to :login
  belongs_to :proposal

end
