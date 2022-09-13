require 'rails_helper'

RSpec.describe 'CreateTask', type: :system, js: true do
  describe 'タスク作成' do
    describe 'ログインしていない' do
      let(:visit_path) { "/tasks/new" }

      it 'ログインページに遷移すること' do
        visit(visit_path)
        expect(page).to have_current_path "/login"
      end
    end

    describe 'ログイン済み' do
      let(:visit_path) { "/tasks/new" }
      let(:user) { create(:user) }
      let(:task_count) { described_class.count }
      let(:name) { 'タスクの名前' }
      let(:description) { 'タスクの説明' }

      context 'フォームの入力値が正常', :aggregate_failures do
        it 'タスク詳細ページに遷移すること' do
          login(user)
          visit(visit_path)
          fill_in 'name', with: name
          fill_in 'description', with: description
          click_button 'タスクを追加'

          expect(page).to have_no_current_path "/tasks/new"
          expect(page).to have_text(name)
        end
      end

      context 'タスク名未記入' do
        it 'エラーが表示されること' do
          login(user)
          visit(visit_path)
          fill_in 'name', with: ''
          fill_in 'description', with: description
          click_button 'タスクを追加'

          expect(page).to have_content "タスクの名前を入力してください"
        end

        it 'ページ遷移しないこと' do
          login(user)
          visit(visit_path)
          fill_in 'name', with: ''
          fill_in 'description', with: description
          click_button 'タスクを追加'

          expect(page).to have_current_path "/tasks/new"
        end
      end

      context 'タスク内容未記入' do
        it 'エラーが表示されること' do
          login(user)
          visit(visit_path)
          fill_in 'name', with: name
          fill_in 'description', with: ''
          click_button 'タスクを追加'

          expect(page).to have_content "タスクの説明を入力してください"
        end

        it 'ページ遷移しないこと' do
          login(user)
          visit(visit_path)
          fill_in 'name', with: name
          fill_in 'description', with: ''
          click_button 'タスクを追加'

          expect(page).to have_current_path "/tasks/new"
        end
      end
    end
  end
end
