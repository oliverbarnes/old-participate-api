class Facebook
  class APIError < StandardError; end

  class << self

    def fetch_user(authentication_code)
      # memoize fetched user data?
      access_token = request_access_token(authentication_code)
      request_user_data(access_token)
    end

    private

      def request_access_token(authentication_code)
        request( token_url(authentication_code) ).parsed_response['access_token']
      end

      def request_user_data(access_token)
        request( me_url(access_token) ).parsed_response.symbolize_keys
      end

      def request(url)
        response = HTTParty.get(url)
        raise APIError.new if response.code != 200
        response
      end

      def token_url(authentication_code)
        config.facebook_graph_url + '/oauth/access_token?' + token_query(authentication_code)
      end

      def token_query(authentication_code)
        {
          client_id:     config.facebook_app_id,
          redirect_uri:  config.facebook_redirect_uri,
          client_secret: config.facebook_app_secret,
          code:          authentication_code
        }.to_query
      end

      def me_url(access_token)
        config.facebook_graph_url + "/me?fields=email&access_token=#{access_token}"
      end

      def config
        Figaro.env
      end
  end
end
