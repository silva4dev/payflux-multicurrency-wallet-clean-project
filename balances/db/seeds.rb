# frozen_string_literal: true

Balance.new(
  id: 'b8bbd006-0318-48ba-b7a4-30dc5920f4c2',
  account_id: 'd6a41403-bbd0-11ee-8a24-0242ac120003',
  balance: 850,
  created_at: Time.now
).save

Balance.new(
  id: 'ab37cbe9-b212-446b-a7ca-3dc8117281d3',
  account_id: 'd6a41504-bbd0-11ee-8a24-0242ac120003',
  balance: 1150,
  created_at: Time.now
).save

Balance.new(
  id: 'd10d6ec7-92ed-4387-a689-422fe1559a30',
  account_id: 'd6a41403-bbd0-11ee-8a24-0242ac120003',
  balance: 800,
  created_at: Time.now
).save

Balance.new(
  id: '5af44c65-fc2f-4cfc-9b8b-5a908bda18b1',
  account_id: 'd6a41504-bbd0-11ee-8a24-0242ac120003',
  balance: 1200,
  created_at: Time.now
).save
