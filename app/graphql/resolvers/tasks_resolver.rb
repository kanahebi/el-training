module Resolvers
  class TasksResolver < AuthResolver
    type [Types::TaskType], null: false

    def resolve
      current_user.tasks.order(created_at: :desc)
    end
  end
end
