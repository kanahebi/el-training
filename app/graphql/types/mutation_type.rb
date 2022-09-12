module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login
    field :delete_task, mutation: Mutations::DeleteTask
    field :update_task, mutation: Mutations::UpdateTask
    field :create_task, mutation: Mutations::CreateTask
  end
end
