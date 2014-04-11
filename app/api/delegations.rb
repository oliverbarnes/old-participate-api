require File.expand_path('../../representers/delegation_representer.rb', __FILE__)

module LiquidFeedback
  class Delegations < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Delegation not found', status: 404
    end

    resource :delegations do
      desc 'Post new delegation'
      params do
        requires :issue_id, desc: "Issue being delegated"
        requires :truster_id, desc: "Member delegating their vote"
        requires :trustee_id, desc: "Member receiving delegation of vote"
        optional :area_id, desc: 'Area being delegated'
        mutually_exclusive :issue_id, :area_id
      end

      post do
        # Refactor into truster.delegate_to( trustee, issue)?
        truster = Member.find params[:truster_id]
        trustee = Member.find params[:trustee_id]
        issue = Issue.find params[:issue_id]
        Delegation.create!( 
                            issue: issue,
                            truster: truster,
                            trustee: trustee
                          ).extend DelegationRepresenter
      end

      desc 'Delete a delegation'
      route_param :id do
        delete do
          Delegation.find( params[:id] ).destroy
        end
      end
    end
  end
end
