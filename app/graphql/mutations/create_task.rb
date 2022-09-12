module Mutations
  class CreateTask < AuthMutation
    graphql_name 'CreateTask'

    field :task, Types::TaskType, null: true

    argument :name, String, required: true
    argument :description, String, required: true

    def resolve(name:, description:)
      super
      task = current_user.tasks.build(name:, description:)
      raise GraphQL::ExecutionError, task.errors.full_messages.join(", ") unless task.save

      {
        task:
      }
    end
  end
end
