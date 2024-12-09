# frozen_string_literal: true

module Infrastructure
  module Repositories
    class BalanceRepository < Domain::Repositories::BalanceRepository
      def find_by_account_id(account_id)
        to_entity(Models::Balance.first(account_id: account_id))
      end
    
      def find_by_id(id)
        to_entity(Models::Balance[id])
      end
    
      def save(balance)
        to_dao(balance).save
      end

      def update(balance)
        found_balance = Models::Balance[balance.id]
        return nil unless found_balance

        found_balance.update(to_dao(balance))
        to_entity(found_balance) 
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
