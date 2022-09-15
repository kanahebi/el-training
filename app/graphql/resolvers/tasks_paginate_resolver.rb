module Resolvers
  class TasksPaginateResolver < AuthResolver
    type Types::TasksPaginateType, null: false

    argument :page, Int, required: false
    argument :per, Int, required: false

    def resolve(page:, per:)
      super
      tasks = current_user.tasks.order(created_at: :desc).page(page).per(per)

      {
        tasks:,
        page_info: pagination(tasks)
      }
    end
  end
end
