# frozen_string_literal: true

module Domain
  module Entity
    class Balance
      attr_reader :id, :account_id, :balance

      private_class_method :new

      def initialize(account_id, balance)
        @id = SecureRandom.uuid
        @account_id = account_id
        @balance = balance
      end

      def self.create(account_id, balance)
        new(account_id, balance)
      end
    end
  end
end
