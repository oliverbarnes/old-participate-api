module LiquidFeedback
  class Issues < Grape::API

    get 'issues' do
      { issues: 'loads' }.to_json
    end

  end
end