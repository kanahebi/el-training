require 'rails_helper'

RSpec.describe Mutations::Login do
  describe 'Mutations::Login' do
    subject { ElTrainingSchema.execute(query, context: , variables:) }

    let(:query) { '' }
    let(:variables) { {} }
    let(:user) { create(:user, email: email, password: password) }
    let(:current_user) { user }
    let(:context) {
      {
        current_user: current_user
      }
    }

    context 'CreateTask Mutation' do
      let(:email) { 'user@example.com' }
      let(:password) { 'password' }
      let(:input_email) { email }
      let(:input_password) { password }
      let(:variables) do
        {
          email: input_email,
          password: input_password
        }
      end
      let(:query) do
        <<~GRAPHQL
          mutation Login($email: String!, $password: String!) {
            login(
              input: {
                email: $email,
                password: $password
              }
            ){
              token
            }
          }
        GRAPHQL
      end

      it 'エラーが返ってこないこと' do
        expect(subject['errors']).to be_blank
      end

      it 'tokenが返ってくること' do
        expect(subject['data']['login']['token']).to eq(user.reload.auth_token)
      end

      context 'emailが空' do
        let(:input_email) { '' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("ログインできませんでした。")
        end
      end

      context 'passwordが空' do
        let(:input_password) { '' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("ログインできませんでした。")
        end
      end

      context 'emailが間違っている' do
        let(:input_email) { 'useruser@example.com' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("ログインできませんでした。")
        end
      end

      context 'passwordが間違っている' do
        let(:input_password) { 'passpasspassword' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("ログインできませんでした。")
        end
      end
    end
  end
end
