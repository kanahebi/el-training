require 'rails_helper'

RSpec.describe Mutations::UpdateTask do
  describe 'Mutations::UpdateTask' do
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

    context 'UpdateTask Mutation' do
      let!(:task) { create(:task, user:) }
      let(:id) { task.id }
      let(:name) { '更新後のタスクの名前' }
      let(:description) { '更新後のタスクの内容' }
      let(:variables) do
        {
          id:,
          name:,
          description:
        }
      end
      let(:query) do
        <<~GRAPHQL
          mutation UpdateTask($id: ID!, $name: String!, $description: String!) {
            updateTask(
              input: {
                id: $id
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

      it 'タスクが更新されていること' do
        expect { subject }.to(change { task.reload.name }.to(name))
      end

      context '存在しないIDを指定' do
        let(:id) { 'ID1234' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("見つかりませんでした。")
        end

        it 'タスクが更新されていないこと' do
          expect { subject }.not_to(change { task.reload.name })
        end
      end

      context 'nameが空' do
        let(:name) { '' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("タスクの名前を入力してください")
        end

        it 'タスクが更新されていないこと' do
          expect { subject }.not_to(change { task.reload.name })
        end
      end

      context 'descriptionが空' do
        let(:description) { '' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("タスクの説明を入力してください")
        end

        it 'タスクが更新されていないこと' do
          expect { subject }.not_to(change { task.reload.description })
        end
      end

      context 'current_userが存在しない' do
        let(:current_user) { nil }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("ログインしてください。")
        end

        it 'タスクが更新されていないこと' do
          expect { subject }.not_to(change { task.reload.description })
        end
      end

      context '違うユーザーのタスク' do
        let(:current_user) { create(:user) }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("見つかりませんでした。")
        end

        it 'タスクが更新されていないこと' do
          expect { subject }.not_to(change { task.reload.description })
        end
      end
    end
  end
end
