# frozen_string_literal: true

require_relative '../interfaces/usecase'

module Application
  module Usecases
    class FindAccountUsecase < Interfaces::Usecase
      def initialize(balance_repository)
        super()
        @balance_repository = balance_repository
      end

      def execute(input_dto)
        @balance_repository.find_by_account_id(input_dto.account_id)
      end
    end
  end
end
