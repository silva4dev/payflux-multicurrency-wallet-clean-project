# frozen_string_literal: true

require_relative '../interfaces/usecase'
require_relative '../../domain/entities/balance_entity'

module Application
  module Usecases
    class CreateBalanceUsecase < Interfaces::Usecase
      def initialize(balance_repository)
        super()
        @balance_repository = balance_repository
      end

      def execute(input_dto)
        balance = Domain::Entities::BalanceEntity.create(input_dto.account_id, input_dto.balance)
        @balance_repository.save(balance)
        balance
      end
    end
  end
end
