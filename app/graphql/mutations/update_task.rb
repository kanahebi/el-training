module Mutations
  class UpdateTask < AuthMutation
    graphql_name 'UpdateTask'

    field :task, Types::TaskType, null: true

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :description, String, required: true

    def resolve(id:, name:, description:)
      super
      task = current_user.tasks.find(id)
      result = task.update(name:, description:)
      raise GraphQL::ExecutionError, task.errors.full_messages.join(", ") unless result

      {
        task:
      }
    end
  end
end
