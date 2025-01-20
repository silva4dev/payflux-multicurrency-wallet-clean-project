# frozen_string_literal: true

require_relative '../dtos/find_account_dto'
require_relative '../usecases/find_account_usecase'
require_relative '../../infrastructure/repositories/balance_repository'

Ruby::App.controllers :balances, map: '/balances' do
  get '/:account_id' do
    content_type :json
    input_dto = Application::Dtos::FindAccountDto::InputDTO.new(account_id: params[:account_id])
    repository = Infrastructure::Repositories::BalanceRepository.new
    usecase = Application::Usecases::FindAccountUsecase.new(repository)
    balance = usecase.execute(input_dto)
    if balance.nil?
      status 404
      { error: 'Balance not found' }.to_json
    else
      output_dto = Application::Dtos::FindAccountDto::OutputDTO.new(
        id: balance.id,
        account_id: balance.account_id, 
        balance: balance.balance, 
        created_at: balance.created_at
      ).to_h
      output_dto.to_json
    end
  end
end
