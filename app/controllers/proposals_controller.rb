class ProposalsController < ApplicationController
  before_action :authenticate!

  include JSONAPI::ActsAsResourceController
end
