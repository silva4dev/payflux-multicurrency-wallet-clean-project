# frozen_string_literal: true

require_relative '../../domain/repositories/balance_repository'
require_relative '../mappers/balance_mapper'

module Infrastructure
  module Repositories
    class BalanceRepository < Domain::Repositories::BalanceRepository
      def find_by_account_id(account_id)
        balance = Balance
                  .where(account_id: account_id)
                  .order(Sequel.desc(:created_at)).first
        to_entity(balance)
      end
    
      def find_by_id(id)
        to_entity(Balance[id])
      end
    
      def save(balance)
        Balance.create(to_dao(balance))
      end

      private

      def to_entity(dao)
        Mappers::BalanceMapper.to_entity(dao)
      end

      def to_dao(entity)
        Mappers::BalanceMapper.to_dao(entity)
      end
    end
  end
end
