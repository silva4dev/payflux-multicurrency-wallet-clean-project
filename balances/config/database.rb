# frozen_string_literal: true

require 'dotenv/load'

Sequel::Model.raise_on_save_failure = false

Sequel::Model.db = case Padrino.env
when :development
  Sequel.connect(ENV['DEV_DATABASE_URL'], loggers: [logger])
when :production
  Sequel.connect(ENV['PROD_DATABASE_URL'], loggers: [logger])
when :test
  Sequel.connect(ENV['TEST_DATABASE_URL'], loggers: [logger])
else
  raise "Unknown environment: #{Padrino.env}"
end
