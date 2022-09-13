require 'rails_helper'

RSpec.describe Resolvers::TaskResolver do
  describe 'Resolvers::TaskResolver' do
    subject do
      mutation = described_class.new(field: nil, object: nil, context:)
      mutation.resolve(id:)
    end

    let(:task) { create(:task, user: user) }
    let(:id) { task.id }
    let(:user) { create(:user) }
    let(:current_user) { user }
    let(:context) {
      {
        current_user: current_user
      }
    }

    it 'タスクが返ってくること' do
      expect(subject).to eq(task)
    end

    context '存在しないIDを指定' do
      let(:id) { 'ID1234' }

      it 'エラーが返ってくること' do
        expect{ subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'current_userが存在しない' do
      let(:current_user) { nil }

      it 'エラーが返ってくること' do
        expect{ subject }.to raise_error(GraphQL::ExecutionError)
      end
    end

    context '違うユーザーのタスク' do
      let(:current_user) { create(:user) }

      it 'エラーが返ってくること' do
        expect{ subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
