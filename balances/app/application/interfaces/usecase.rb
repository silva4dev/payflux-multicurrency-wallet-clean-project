# frozen_string_literal: true

module Application 
  module Interfaces
    class Usecase
      def execute(input_dto = {})
        raise NotImplementedError
      end
    end
  end
end
