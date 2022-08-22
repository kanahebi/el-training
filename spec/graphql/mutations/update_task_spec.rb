require 'rails_helper'

RSpec.describe Mutations::UpdateTask do
  describe 'Mutations::UpdateTask' do
    subject { ElTrainingSchema.execute(query, variables: variables) }
    let(:query) { '' }
    let(:variables) { {} }

    context 'UpdateTask Mutation' do
      let!(:task) { create(:task) }
      let(:id) { task.id }
      let(:name) { '更新後のタスクの名前' }
      let(:description) { '更新後のタスクの内容' }
      let(:variables) {
        {
          id: id,
          name: name,
          description: description
        }
      }
      let(:query) { 
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
      }

      it 'エラーが返ってこないこと' do
        expect(subject['errors']).to be_blank
      end

      it 'タスクが更新されていること' do
        expect { subject }.to change { task.reload.name }.to(name)
      end
  
      context '存在しないIDを指定' do
        let(:id) { 'ID1234' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("見つかりませんでした。")
        end

        it 'タスクが更新されていないこと' do
          expect { subject }.not_to change { task.reload.name }
        end
      end

      context 'nameが空' do
        let(:name) { '' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("Name can't be blank")
        end

        it 'タスクが更新されていないこと' do
          expect { subject }.not_to change { task.reload.name }
        end
      end

      context 'descriptionが空' do
        let(:description) { '' }

        it 'エラーが返ってくること' do
          expect(subject['errors'][0]['message']).to include("Description can't be blank")
        end

        it 'タスクが更新されていないこと' do
          expect { subject }.not_to change { task.reload.description }
        end
      end
    end
  end
end
