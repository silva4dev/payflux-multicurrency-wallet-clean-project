# frozen_string_literal: true

require_relative '../app/infrastructure/repositories/balance_repository'
require_relative '../app/application/usecases/create_balance_usecase'
require_relative '../app/infrastructure/events/balance_consumer'

RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

Padrino::Logger::Config[:development][:log_level] = :devel
Padrino::Logger::Config[:development][:log_static] = true

$LOAD_PATH.unshift Padrino.root('lib')

Padrino.dependency_paths.unshift Padrino.root('config/initializers/*.rb')

Padrino.before_load do
  Padrino.dependency_paths << Padrino.root('app/domain/**/**/*.rb')
  Padrino.dependency_paths << Padrino.root('app/application/**/**/*.rb')
end

Padrino.after_load do
  Padrino.dependency_paths << Padrino.root('app/infrastructure/models/**/*.rb')
  Padrino.dependency_paths << Padrino.root('app/domain/**/**/*.rb')
  Padrino.dependency_paths << Padrino.root('app/application/**/**/*.rb')
  Padrino.dependency_paths << Padrino.root('app/infrastructure/**/**/*.rb')
end

Thread.new do
  kafka_brokers = ENV.fetch('KAFKA_BOOTSTRAP_SERVERS').split(',')
  kafka_topic = ENV.fetch('KAFKA_GROUP_ID')
  repository = Infrastructure::Repositories::BalanceRepository.new
  usecase = Application::Usecases::CreateBalanceUsecase.new(repository)
  kafka_consumer = Infrastructure::Events::BalanceConsumer.new(kafka_brokers, kafka_topic, usecase)
  loop do
    kafka_consumer.consume
  end
end

Padrino.load!
