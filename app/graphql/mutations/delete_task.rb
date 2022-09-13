module Mutations
  class DeleteTask < AuthMutation
    graphql_name 'DeleteTask'

    field :task, Types::TaskType, null: true
    field :result, Boolean, null: true

    argument :id, ID, required: true

    def resolve(id:)
      super
      task = current_user.tasks.find(id)
      task.destroy
      {
        task:,
        result: task.errors.blank?
      }
    end
  end
end
