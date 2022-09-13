require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'types' do
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

    context 'tasks' do
      before do
        create_list(:task, 10, user:)
      end

      let!(:task) { create(:task, user:) }
      let(:hashed_task) do
        {
          'id' => task.id,
          'name' => task.name,
          'description' => task.description
        }
      end
      let(:query) do
        <<~GRAPHQL
          query GetTasks {
            tasks {
              id
              name
              description
            }
          }
        GRAPHQL
      end

      it '作成したタスクが含まれていること' do
        expect(subject['data']['tasks']).to(be_any { |t| t['id'] == task.id })
      end

      it '全てのタスクが返ってくること' do
        expect(subject['data']['tasks'].size).to eq(Task.all.size)
      end
    end

    context 'task' do
      let(:task) { create(:task, user:) }
      let(:id) { task.id }
      let(:hashed_task) do
        {
          'id' => task.id,
          'name' => task.name,
          'description' => task.description
        }
      end
      let(:query) do
        <<~GRAPHQL
          query GetTask($id: ID!) {
            task(id: $id) {
              id
              name
              description
            }
          }
        GRAPHQL
      end
      let(:variables) do
        {
          id:
        }
      end

      it 'タスクが返ってくること' do
        expect(subject['data']['task']['id']).to eq(task.id)
      end
    end
  end
end
