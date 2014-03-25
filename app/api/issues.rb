require File.expand_path('../../representers/issue_representer.rb', __FILE__)

module LiquidFeedback
  class Issues < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Issue not found', status: 404
    end

    resource :issues do
      desc 'List issues'
      get do
        Issue.all.extend( IssuesRepresenter )
      end

      desc 'Show issue'
      params do
        requires :id, desc: "Issue id"
      end

      route_param :id do
        get do
          Issue.find(params[:id]).extend( IssueRepresenter )
        end
      end

      desc 'Post new issue'
      params do
        requires :title, desc: "Title of the issue"
        requires :description, desc: "Description of the issue"
      end

      post do
        Issue.create! params #TODO: sanitize
      end
    end
  end
end