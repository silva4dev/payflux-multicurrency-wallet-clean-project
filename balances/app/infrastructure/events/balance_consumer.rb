# frozen_string_literal: true

require 'kafka'

require_relative '../../application/interfaces/kafka_interface'
require_relative '../../application/dtos/create_balance_dto'

module Infrastructure
  module Events
    class BalanceConsumer < Application::Interfaces::KafkaInterface
      def initialize(kafka_brokers, kafka_topic, usecase)
        super()
        @kafka = Kafka.new(seed_brokers: kafka_brokers, client_id: kafka_topic)
        @kafka_topic = kafka_topic
        @usecase = usecase
      end

      def consume
        consumer = @kafka.consumer(group_id: @kafka_topic) 
        consumer.subscribe(@kafka_topic)
        consumer.each_message do |message|
          process_message(message)
        end
      end

      private

      def process_message(message)
        data = JSON.parse(message.value)
        return unless data

        input_dto = Application::Dtos::CreateBalanceDto::InputDTO.new(
          account_id: data['Payload']['account_id_from'], 
          balance: data['Payload']['balance_account_id_from']
        )
        @usecase.execute(input_dto)
        
        input_dto = Application::Dtos::CreateBalanceDto::InputDTO.new(
          account_id: data['Payload']['account_id_to'], 
          balance: data['Payload']['balance_account_id_to']
        )
        @usecase.execute(input_dto)
      end
    end
  end
end
