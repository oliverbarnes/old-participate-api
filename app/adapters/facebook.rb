class Facebook
  class GraphApiError < StandardError; end

  class << self

    def authenticate(app_token)
      access_token = request_access_token(app_token)
      request_user_data(access_token)
    end

    private

      def request_access_token(app_token)
        request( token_url(app_token) ).parsed_response['access_token']
      end

      def request_user_data(access_token)
        request( me_url(access_token) ).parsed_response.symbolize_keys
      end

      def request(url)
        response = HTTParty.get(url)
        raise GraphApiError.new if response.code != 200
        response
      end

      def token_url(app_token)
        graph_url + '/oauth/access_token?' + token_query(app_token)
      end

      def token_query(app_token)
        {
          client_id:     app_id,
          redirect_uri:  redirect_uri,
          client_secret: app_secret,
          code:          app_token
        }.to_query
      end

      def me_url(access_token)
        graph_url + "/me?fields=email&access_token=#{access_token}"
      end

      def graph_url
        Rails.application.secrets.facebook_graph_url
      end

      def redirect_uri
        Rails.application.secrets.facebook_redirect_uri
      end

      def app_id
        Rails.application.secrets.facebook_app_id
      end

      def app_secret
        Rails.application.secrets.facebook_app_secret
      end
  end
end
