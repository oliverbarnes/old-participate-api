require File.expand_path('../../representers/suggestion_representer.rb', __FILE__)

module LiquidFeedback
  class InterestsInIssues < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Interest in issue not found', status: 404
    end

    resource :interests_in_issues do
      desc 'List interests in issues'
      # params do
      #   # requires :initiative_id, desc: "Initiative the suggestions is for"
      # end
      get do
        # InterestInIssue.where( issue_id: params[:issue_id] ).all.extend InterestsInIssuesRepresenter 
        InterestInIssue.all.extend InterestsInIssuesRepresenter 
      end

      desc 'Show interest in issue'
      params do
        requires :id, desc: "Interest id"
      end

      route_param :id do
        get do
          InterestInIssue.find( params[:id] ).extend InterestInIssueRepresenter 
        end
      end

      desc 'Post new interest in issue'
      params do
        requires :issue_id, desc: "Issue of interest"
        requires :member_id, desc: "Interested member"
      end

      post do
        InterestInIssue.create!(
          issue_id: params[:issue_id],
          member_id: params[:member_id]
        ).extend InterestInIssueRepresenter
      end

      desc 'Delete interest in an issue'
      route_param :id do
        delete do
          InterestInIssue.find( params[:id] ).destroy
        end
      end
    end
  end
end