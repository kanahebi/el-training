module Resolvers
  class TaskResolver < AuthResolver
    type Types::TaskType, null: true
    argument :id, ID, required: true

    def resolve(id:)
      super
      current_user.tasks.find(id)
    end
  end
end
