# frozen_string_literal: true

module Application
  module Dtos
    class FindAccountDto
      InputDTO = Struct.new(:account_id, keyword_init: true)
      OutputDTO = Struct.new(:id, :account_id, :balance, :created_at, keyword_init: true)
    end
  end
end
