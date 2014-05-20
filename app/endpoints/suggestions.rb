require File.expand_path('../../representers/suggestion_representer.rb', __FILE__)

module LiquidFeedback
  class Suggestions < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Suggestion not found', status: 404
    end

    resource :suggestions do
      desc 'List suggestions'
      params do
        requires :initiative_id, desc: "Initiative the suggestions is for"
      end
      get do
        Suggestion.where( initiative_id: params[:initiative_id] ).all.extend SuggestionsRepresenter 
      end

      desc 'Show suggestion'
      params do
        requires :id, desc: "Suggestion id"
      end

      route_param :id do
        get do
          Suggestion.find( params[:id] ).extend SuggestionRepresenter 
        end
      end

      desc 'Post new suggestion'
      params do
        requires :body, desc: "Suggestion text body"
        requires :initiative_id, desc: "Initiative the suggestion is for"
      end

      post do
        Suggestion.create!(
          body: params[:body],
          initiative_id: params[:initiative_id]
        ).extend SuggestionRepresenter ;
      end

      desc 'Update an suggestion'
      params do
        requires :id, desc: "Suggestion id"
        requires :body, desc: "Suggestion text body"
      end

      patch do
        suggestion = Suggestion.find( params[:id] )
        suggestion.update_attributes!(
          body: params[:body]
        )
        suggestion.extend SuggestionRepresenter;
      end

      desc 'Delete an suggestion'
      route_param :id do
        delete do
          Suggestion.find( params[:id] ).destroy
        end
      end
    end
  end
end