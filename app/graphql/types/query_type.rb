module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :task, Types::TaskType, null: true do
      description "Find Task by ID"
      argument :id, ID, required: true
    end

    def task(id:)
      Task.find(id)
    end

    field :tasks, [Types::TaskType], null: false

    def tasks
      Task.all.order(created_at: :desc)
    end
  end
end
