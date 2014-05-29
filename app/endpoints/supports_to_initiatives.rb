require File.expand_path('../../representers/support_to_initiative_representer.rb', __FILE__)

module Participate
  class SupportsToInitiatives < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Support to initiative not found', status: 404
    end

    resource :supports_to_initiatives do
      desc 'List supports to initiatives'
      get do
        SupportToInitiative.all.extend SupportsToInitiativesRepresenter 
      end

      desc 'Show support to initiative'
      params do
        requires :id, desc: "Support id"
      end

      route_param :id do
        get do
          SupportToInitiative.find( params[:id] ).extend SupportToInitiativeRepresenter 
        end
      end

      desc 'Post new support to initiative'
      params do
        requires :initiative_id, desc: "Supported initiative"
        requires :member_id, desc: "Supporting member"
      end

      post do
        SupportToInitiative.create!(
          initiative_id: params[:initiative_id],
          member_id: params[:member_id]
        ).extend SupportToInitiativeRepresenter
      end

      desc 'Delete support to initiative'
      route_param :id do
        delete do
          SupportToInitiative.find( params[:id] ).destroy
        end
      end
    end
  end
end