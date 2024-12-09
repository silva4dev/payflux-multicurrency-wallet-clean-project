# frozen_string_literal: true

Sequel::Model.raise_on_save_failure = false

Sequel::Model.db = case Padrino.env
when :development
  Sequel.connect("mysql2://root:root@0.0.0.0:3306/wallet_development", loggers: [logger])
when :production
  Sequel.connect("mysql2://root:root@0.0.0.0:3306/wallet_production", loggers: [logger])
when :test
  Sequel.connect("mysql2://root:root@0.0.0.0:3306/wallet_test", loggers: [logger])
else
  raise "Unknown environment: #{Padrino.env}"
end