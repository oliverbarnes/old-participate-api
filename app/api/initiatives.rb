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
      end

      post do
        author = Member.find params[:author_id]
        Initiative.create!(
          title: params[:title],
          description: params[:description],
          author: author
        ).extend InitiativeRepresenter
      end

      desc 'Update an initiative'
      params do
        requires :id, desc: "Initiative id"
        optional :name, desc: "Initiative of the initiative"
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