# frozen_string_literal: true

module Types
  class NotificationSettingType < Types::BaseObject
    field :id, ID, null: false
    field :setting_config_type, String
    field :setting_config_params, GraphQL::Types::JSON
    field :user_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :by_email, Boolean
    field :by_phone, Boolean
  end
end
