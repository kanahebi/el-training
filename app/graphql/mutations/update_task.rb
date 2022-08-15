module Mutations
  class UpdateTask < BaseMutation
    graphql_name 'UpdateTask'

    field :task, Types::TaskType, null: true

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :description, String, required: true

    def resolve(id:, name:, description:)
      task = Task.find(id)
      raise GraphQL::ExecutionError, task.errors.full_messages.join(", ") unless task.update(name:, description:)

      {
        task:
      }
    end
  end
end
