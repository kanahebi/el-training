module Mutations
  class AuthMutation < BaseMutation
    def resolve(**args)
      login_required!
    end

    def current_user
      context[:current_user]
    end

    private

    def login_required!
      raise GraphQL::ExecutionError, 'ログインしてください。' unless current_user
    end
  end
end
