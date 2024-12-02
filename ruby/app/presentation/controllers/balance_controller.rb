# frozen_string_literal: true

Ruby::App.controllers :balances, map: '/balances' do
  get :index do
    content_type :json
    { message: 'Hello World!' }.to_json
  end
end
