require 'rails_helper'

RSpec.describe 'ShowTask', type: :system, js: true do
  describe 'タスク詳細' do
    describe 'ログインしていない' do
      let(:visit_path) { "/tasks/#{task.id}" }
      let(:task) { create(:task, user: create(:user)) }

      it 'ログインページに遷移すること' do
        visit(visit_path)
        expect(page).to have_current_path "/login"
      end
    end

    describe 'ログイン済み' do
      context '自分のタスク' do
        let(:visit_path) { "/tasks/#{task.id}" }
        let(:user) { create(:user) }
        let(:task) { create(:task, user:) }

        it 'タスクの名前が表示されている' do
          login(user)
          visit(visit_path)
          expect(page).to have_text(task.name)
        end

        it 'タスクの説明が表示されている' do
          login(user)
          visit(visit_path)
          expect(page).to have_text(task.description)
        end
      end

      context '他のユーザーのタスク' do
        let(:visit_path) { "/tasks/#{task.id}" }
        let(:user) { create(:user) }
        let!(:task) { create(:task, name: '他のユーザーのタスク', user: create(:user, :other)) }

        it 'エラーメッセージが表示されること' do
          login(user)
          visit(visit_path)
          expect(page).to have_text('見つかりませんでした。')
        end

        it 'タスクの中身が見えないこと' do
          login(user)
          visit(visit_path)
          expect(page).not_to have_text(task.name)
        end
      end
    end
  end
end
