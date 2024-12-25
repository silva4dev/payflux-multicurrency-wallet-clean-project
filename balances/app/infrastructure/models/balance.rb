# frozen_string_literal: true

module Infrastructure
  module Models
    class Balance < Sequel::Model
      def validate
        super
        validates_presence %w[:account_id :balance]
      end
    end
  end
end
