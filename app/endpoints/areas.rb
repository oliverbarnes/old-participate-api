require File.expand_path('../../representers/area_representer.rb', __FILE__)

module LiquidFeedback
  class Areas < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Area not found', status: 404
    end

    resource :areas do
      desc 'List areas'
      get do
        Area.all.extend AreasRepresenter 
      end

      desc 'Show area'
      params do
        requires :id, desc: "Area id"
      end

      route_param :id do
        get do
          [Area.find( params[:id] )].extend AreasRepresenter 
        end
      end

      desc 'Post new area'
      params do
        requires :name, desc: "Area of the area"
        requires :description, desc: "Description of the area"
      end

      post do
        [Area.create!(
          name: params[:name],
          description: params[:description]
        )].extend AreasRepresenter
      end

      desc 'Update an area'
      params do
        requires :id, desc: "Area id"
        optional :name, desc: "Area of the area"
        optional :description, desc: "Description of the area"
      end

      patch do
        area = Area.find( params[:id] )
        area.update_attributes!(
          name: params[:name],
          description: params[:description]
        )
        [area].extend AreasRepresenter
      end

      desc 'Delete an area'
      route_param :id do
        delete do
          Area.find( params[:id] ).destroy
        end
      end
    end
  end
end