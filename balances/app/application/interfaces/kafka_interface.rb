# frozen_string_literal: true

module Application 
  module Interfaces 
    class KafkaInterface 
      def consume(topic, group_id)
        raise NotImplementedError
      end
    end
  end
end
