# frozen_string_literal: true

module Application
  module Dtos
    class CreateBalanceDto
      InputDTO = Struct.new(:account_id, :balance, keyword_init: true)
    end
  end
end
