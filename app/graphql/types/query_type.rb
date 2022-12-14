module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :task, resolver: Resolvers::TaskResolver
    field :tasks, resolver: Resolvers::TasksResolver
    field :tasks_paginate, resolver: Resolvers::TasksPaginateResolver

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
  end
end
