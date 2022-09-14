# frozen_string_literal: true

module Types
  class TasksType < Types::BaseObject
    #field :pagination, PaginationType, null: true
    field :tasks, [Types::TaskType], null: true do
      argument :id, ID, required: true
      argument :name, String, required: true
      argument :description, String, required: true
      argument :created_at, GraphQL::Types::ISO8601DateTime, required: true
      argument :updated_at, GraphQL::Types::ISO8601DateTime, required: true
    end
  end
end
