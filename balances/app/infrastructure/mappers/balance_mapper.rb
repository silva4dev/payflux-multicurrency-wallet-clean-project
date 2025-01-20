# frozen_string_literal: true

require_relative '../../domain/entities/balance_entity'

module Infrastructure
  module Mappers
    class BalanceMapper 
      def self.to_entity(dao)
        Domain::Entities::BalanceEntity.create(
          dao[:account_id],
          dao[:balance],
          id: dao[:id],
          created_at: dao[:created_at]
        )
      end

      def self.to_dao(entity)
        {
          id: entity.id, 
          account_id: entity.account_id,
          balance: entity.balance,
          created_at: entity.created_at
        }
      end
    end
  end
end
