module Resolvers
  class TasksResolver < AuthResolver
    type [Types::TaskType], null: false

    def resolve
      super
      current_user.tasks.order(created_at: :desc)
    end
  end
end
