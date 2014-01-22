require File.expand_path('../../representers/issue_representer.rb', __FILE__)

module LiquidFeedback
  class Issues < Grape::API

    desc 'List issues'
    get :issues do
      Issue.all.extend( IssuesRepresenter )
    end

    #untested, just for sanity checks for now
    desc 'Show issue'
    get :issue do
      Issue.last.extend( IssueRepresenter )
    end

  end
end