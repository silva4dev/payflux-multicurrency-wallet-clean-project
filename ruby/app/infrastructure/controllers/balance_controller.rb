Ruby::App.controllers :balances, map: '/api/v1/balances' do
  get :index do
    balances = [
      {
       id: 1,
       name: "Balance 1",
       amount: 100
      },
      {
       id: 2,
       name: "Balance 2",
       amount: 200
      }
    ]
    content_type :json
    balances.to_json
  end
end
