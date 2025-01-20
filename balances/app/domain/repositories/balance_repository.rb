# frozen_string_literal: true

module Domain 
  module Repositories
    class BalanceRepository
      def find_by_account_id(account_id)
        raise NotImplementedError
      end
    
      def save(balance)
        raise NotImplementedError
      end
    end
  end
end
