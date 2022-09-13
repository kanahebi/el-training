require 'rails_helper'

RSpec.describe Resolvers::TasksResolver do
  describe 'Resolvers::TasksResolver' do
    subject do
      mutation = described_class.new(field: nil, object: nil, context:)
      mutation.resolve
    end

    before do
      create_list(:task, 10, user:)
    end

    let(:other_user_task) { create(:task, user: create(:user)) }
    let(:task) { create(:task, user:) }
    let(:user) { create(:user) }
    let(:current_user) { user }
    let(:context) do
      {
        current_user:
      }
    end

    it 'タスクの一覧が返ってくること' do
      expect(subject).to match_array(current_user.tasks)
    end

    it '他のユーザーのタスクは含まれていないこと' do
      expect(subject).not_to include(other_user_task)
    end

    context 'current_userが存在しない' do
      let(:current_user) { nil }

      it 'エラーが返ってくること' do
        expect { subject }.to raise_error(GraphQL::ExecutionError)
      end
    end
  end
end
