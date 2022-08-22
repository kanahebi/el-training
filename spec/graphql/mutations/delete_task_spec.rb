require 'rails_helper'

RSpec.describe Mutations::DeleteTask do
  describe 'Mutations::DeleteTask' do
    subject { ElTrainingSchema.execute(query, variables: variables) }
    let(:query) { '' }
    let(:variables) { {} }

    context 'DeleteTask Mutation' do
      let!(:task) { create(:task) }
      let(:id) { task.id }
      let(:variables) {
        {
          id: id,
        }
      }
      let(:query) { 
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
      }

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
          expect { subject }.to change(Task, :count).by(0)
        end
      end
    end
  end
end
