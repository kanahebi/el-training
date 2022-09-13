module Mutations
  class Login < BaseMutation
    graphql_name 'Login'

    field :token, String, null: true

    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(email:, password:)
      user = User.find_by(email:)
      raise GraphQL::ExecutionError, 'ログインできませんでした。' if user.blank?

      user.regenerate_auth_token
      raise GraphQL::ExecutionError, 'ログインできませんでした。' unless user.authenticate(password)

      {
        token: user.auth_token
      }
    end
  end
end
