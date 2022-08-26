require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'types' do
    subject { ElTrainingSchema.execute(query) }

    let(:query) { '' }

    context 'tasks' do
      before do
        create_list(:task, 10)
      end

      let!(:task) { create(:task) }
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
  end
end
