# frozen_string_literal: true

module Types
  class TasksPaginateType < Types::BaseObject
    field :tasks, [Types::TaskType], null: false
    field :page_info, Types::PaginationType, null: false
  end
end
