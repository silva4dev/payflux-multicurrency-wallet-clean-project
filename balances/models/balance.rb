# frozen_string_literal: true

require 'sequel'
require 'padrino'

require_relative '../config/database'

class Balance < Sequel::Model
  unrestrict_primary_key

  plugin :validation_helpers

  def validate
    super()
    validates_presence %i[id account_id balance]
  end
end
