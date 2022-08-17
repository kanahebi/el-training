module Mutations
  class CreateTask < BaseMutation
    graphql_name 'CreateTask'

    field :task, Types::TaskType, null: true

    argument :name, String, required: true
    argument :description, String, required: true

    def resolve(name:, description:)
      task = Task.new(name:, description:)
      raise GraphQL::ExecutionError, task.errors.full_messages.join(", ") unless task.save

      {
        task:
      }
    end
  end
end
