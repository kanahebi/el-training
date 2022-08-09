module Mutations
  class CreateTask < BaseMutation
    graphql_name 'CreateTask'

    field :task, Types::TaskType, null: true
    field :result, Boolean, null: true

    argument :name, String, required: true
    argument :description, String, required: true

    def resolve(name:, description:)
      task = Task.create(name: name, description: description)
      {
        task: task,
        result: task.errors.blank?
      }
    end
  end
end
