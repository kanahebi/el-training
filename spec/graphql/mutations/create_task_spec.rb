require 'rails_helper'

RSpec.describe Mutations::CreateTask do
  describe 'Mutations::CreateTask' do
    subject { ElTrainingSchema.execute(query, context:, variables:) }

    let(:query) { '' }
    let(:variables) { {} }
    let(:user) { create(:user) }
    let(:current_user) { user }
    let(:context) do
      {
        current_user:
      }
    end

    context 'CreateTask Mutation' do
      let(:name) { 'タスクの名前' }
      let(:description) { 'タスクの内容' }
      let(:variables) do
        {
          name:,
          description:
        }
      end
      let(:query) do
        <<~GRAPHQL
          mutation CreateTask($name: String!, $description: String!) {
            createTask(
              input: {
                name: $name,
                description: $description
              }
            ){
              task {
                id
                name
                description
              }
            }
          }
        GRAPHQL
      end

      it 'エラーが返ってこないこと' do
        expect(subject['errors']).to be_blank
      end

      it '新しいタスクが作成されている' do
        expect { subject }.to change(Task, :count).by(1)
      end

      context 'nameが空' do
        let(:name) { '' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("タスクの名前を入力してください")
        end

        it '新しいタスクが作成されていないこと' do
          expect { subject }.not_to change(Task, :count)
        end
      end

      context 'descriptionが空' do
        let(:description) { '' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("タスクの説明を入力してください")
        end

        it '新しいタスクが作成されていないこと' do
          expect { subject }.not_to change(Task, :count)
        end
      end

      context 'current_userが存在しない' do
        let(:current_user) { nil }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("ログインしてください。")
        end

        it '新しいタスクが作成されていないこと' do
          expect { subject }.not_to change(Task, :count)
        end
      end
    end
  end
end
