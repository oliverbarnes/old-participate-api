module LiquidFeedback
  class API < Grape::API
    mount ::LiquidFeedback::Issues
    # add_swagger_documentation api_version: 'v1'
  end
end