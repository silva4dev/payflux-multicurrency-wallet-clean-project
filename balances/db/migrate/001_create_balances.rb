# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :balances do
      String :id, primary_key: true
      String :account_id
      Float :balance
      DateTime :created_at
    end
  end

  down do
    drop_table :balances
  end
end
