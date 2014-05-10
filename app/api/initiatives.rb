require File.expand_path('../../representers/initiative_representer.rb', __FILE__)

module LiquidFeedback
  class Initiatives < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Initiative not found', status: 404
    end

    resource :initiatives do
      desc 'List initiatives'
      get do
        Initiative.all.extend InitiativesRepresenter 
      end

      desc 'Show initiative'
      params do
        requires :id, desc: "Initiative id"
      end

      route_param :id do
        get do
          Initiative.find( params[:id] ).extend InitiativeRepresenter 
        end
      end

      desc 'Post new initiative'
      params do
        requires :title, desc: "Title of the initiative"
        requires :description, desc: "Description of the initiative"
        requires :author_id, desc: "Author of the initiative"
        optional :area_id, desc: "Area the initiative belongs to"
        optional :issue_id, desc: "Issue the initiative belongs to"
        mutually_exclusive :area_id, :issue_id
      end

      post do
        author = Member.find params[:author_id]
        area = Area.find params[:area_id] if params[:area_id]
        issue = Issue.find params[:issue_id] if params[:issue_id]
        Initiative.create!(
          title: params[:title],
          description: params[:description],
          author: author,
          area: area,
          issue: issue
        ).extend InitiativeRepresenter
      end

      desc 'Update an initiative'
      params do
        requires :id, desc: "Initiative id"
        optional :title, desc: "Initiative of the initiative"
        optional :description, desc: "Description of the initiative"
      end

      patch do
        initiative = Initiative.find( params[:id] )
        initiative.update_attributes!(
          title: params[:title],
          description: params[:description]
        )
        initiative.extend InitiativeRepresenter
      end

      desc 'Delete an initiative'
      route_param :id do
        delete do
          Initiative.find( params[:id] ).destroy
        end
      end
    end
  end
end