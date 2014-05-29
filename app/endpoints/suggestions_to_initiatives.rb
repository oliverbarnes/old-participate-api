require File.expand_path('../../representers/suggestion_to_initiative_representer.rb', __FILE__)

module LiquidFeedback
  class SuggestionsToInitiatives < Grape::API
    rescue_from Mongoid::Errors::DocumentNotFound do
      error_response message: 'Suggestion not found', status: 404
    end

    resource :suggestions do
      desc 'List suggestions'
      params do
        requires :initiative_id, desc: "Initiative the suggestions is for"
      end
      get do
        SuggestionToInitiative.where( initiative_id: params[:initiative_id] ).all.extend SuggestionsToInitiativesRepresenter 
      end

      desc 'Show suggestion'
      params do
        requires :id, desc: "Suggestion id"
      end

      route_param :id do
        get do
          [SuggestionToInitiative.find( params[:id] )].extend SuggestionsToInitiativesRepresenter 
        end
      end

      desc 'Post new suggestion'
      params do
        requires :body, desc: "Suggestion text body"
        requires :initiative_id, desc: "Initiative the suggestion is for"
      end

      post do
        [SuggestionToInitiative.create!(
                  body: params[:body],
                  initiative_id: params[:initiative_id]
                )].extend SuggestionsToInitiativesRepresenter ;
      end

      desc 'Update an suggestion'
      params do
        requires :id, desc: "Suggestion id"
        requires :body, desc: "Suggestion text body"
      end

      patch do
        suggestion = SuggestionToInitiative.find( params[:id] )
        suggestion.update_attributes!(
          body: params[:body]
        )
        [suggestion].extend SuggestionsToInitiativesRepresenter;
      end

      desc 'Delete an suggestion'
      route_param :id do
        delete do
          SuggestionToInitiative.find( params[:id] ).destroy
        end
      end
    end
  end
end