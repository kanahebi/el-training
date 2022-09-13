require 'rails_helper'

RSpec.describe Mutations::DeleteTask do
  describe 'Mutations::DeleteTask' do
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

    context 'DeleteTask Mutation' do
      let!(:task) { create(:task, user:) }
      let(:id) { task.id }
      let(:variables) do
        {
          id:
        }
      end
      let(:query) do
        <<~GRAPHQL
          mutation DeleteTask($id: ID!) {
            deleteTask(
              input: {
                id: $id
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

      it 'タスクが削除されている' do
        expect { subject }.to change(Task, :count).by(-1)
      end

      context '存在しないIDを指定' do
        let(:id) { 'ID1234' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("見つかりませんでした。")
        end

        it 'タスクが削除されていないこと' do
          expect { subject }.not_to change(Task, :count)
        end
      end

      context 'current_userが存在しない' do
        let(:current_user) { nil }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("ログインしてください。")
        end

        it 'タスクが削除されていないこと' do
          expect { subject }.not_to change(Task, :count)
        end
      end

      context '違うユーザーのタスク' do
        let(:current_user) { create(:user) }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("見つかりませんでした。")
        end

        it 'タスクが削除されていないこと' do
          expect { subject }.not_to change(Task, :count)
        end
      end
    end
  end
end
