require File.expand_path('../../representers/vote_representer.rb', __FILE__)

module Participate
  class Votes < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Vote not found', status: 404
    end

    resource :votes do
      desc 'Post new vote'
      params do
        requires :issue_id, desc: "Issue being voted on"
        requires :voter_id, desc: "Voter"
        requires :grade, desc: "Grade - positive numbers mean acceptance, negative mean rejection. Value indicates preference (1 is highest)"
      end

      post do
        voter = Member.find params[:voter_id]
        [Vote.create!( 
                      issue_id: params[:issue_id],
                      grade: params[:grade].to_i,
                      voter: voter )].extend VotesRepresenter
      end

      desc 'Delete a vote'
      route_param :id do
        delete do
          Vote.find( params[:id] ).destroy
        end
      end
    end
  end
end
