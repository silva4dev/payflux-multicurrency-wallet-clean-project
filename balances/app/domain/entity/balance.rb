# frozen_string_literal: true

module Domain
  module Entity
    class Balance
      attr_reader :id, :account_id, :balance, :created_at

      private_class_method :new

      def initialize(account_id, balance, id: SecureRandom.uuid, created_at: Time.now)
        @id = id
        @account_id = account_id
        @balance = balance
        @created_at = created_at
      end

      def self.create(account_id, balance, id: SecureRandom.uuid, created_at: Time.now)
        new(account_id, balance, id: id, created_at: created_at)
      end
    end
  end
end
