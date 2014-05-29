require File.expand_path('../../representers/area_membership_representer.rb', __FILE__)

module Participate
  class AreaMemberships < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Area membership not found', status: 404
    end

    resource :area_memberships do
      desc 'List area memberships'
      get do
        AreaMembership.all.extend AreaMembershipsRepresenter 
      end

      desc 'Show area membership'
      params do
        requires :id, desc: "Area membership id"
      end

      route_param :id do
        get do
          [AreaMembership.find( params[:id] )].extend AreaMembershipsRepresenter 
        end
      end

      desc 'Post new area membership'
      params do
        requires :area_id, desc: "Membership area"
        requires :member_id, desc: "Area member"
      end

      post do
        [AreaMembership.create!(
          area_id: params[:area_id],
          member_id: params[:member_id]
        )].extend AreaMembershipsRepresenter
      end

      desc 'Delete area membership'
      route_param :id do
        delete do
          AreaMembership.find( params[:id] ).destroy
        end
      end
    end
  end
end