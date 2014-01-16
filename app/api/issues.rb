module LiquidFeedback
  class Issues < Grape::API

    desc 'List issues'
    get :issues do
      Issue.all
    end

  end
end