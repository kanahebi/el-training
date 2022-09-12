module Resolvers
  class AuthResolver < BaseResolver
    def resolve(**args)
      login_required!
    end

    def current_user
      context[:current_user]
    end

    private

    def login_required!
      raise GraphQL::ExecutionError, 'login required!!' unless context[:current_user]
    end
  end
end
