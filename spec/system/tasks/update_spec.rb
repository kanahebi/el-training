require 'rails_helper'

RSpec.describe 'UpdateTask', type: :system, js: true do
  describe 'タスク更新' do
    describe 'ログインしていない' do
      let(:visit_path) { "/tasks/#{task.id}/edit" }
      let(:task) { create(:task, user: create(:user)) }

      it 'ログインページに遷移すること' do
        visit(visit_path)
        expect(page).to have_current_path "/login"
      end
    end

    describe 'ログイン済み' do
      context '自分のタスク' do
        let(:visit_path) { "/tasks/#{task.id}/edit" }
        let(:user) { create(:user) }
        let(:task) { create(:task, user:) }

        context 'フォームの入力値が正常' do
          let(:name) { 'タスクの名前変更' }
          let(:description) { 'タスクの説明変更' }

          it 'タスク詳細ページに遷移すること' do
            login(user)
            visit(visit_path)
            fill_in 'name', with: name
            fill_in 'description', with: description
            click_button 'タスクを更新'
            expect(page).to have_no_current_path "/tasks/#{task.id}"
          end

          it 'タスクが更新されていること' do
            login(user)
            visit(visit_path)
            fill_in 'name', with: name
            fill_in 'description', with: description
            click_button 'タスクを更新'
            expect(page).to have_text(name)
          end
        end

        context 'タスク名未記入' do
          let(:name) { '' }
          let(:description) { 'タスクの説明変更' }

          it 'エラーが表示されること' do
            login(user)
            visit(visit_path)
            fill_in 'name', with: name
            fill_in 'description', with: description
            click_button 'タスクを更新'
            expect(page).to have_content "タスクの名前を入力してください"
          end

          it 'ページ遷移しないこと' do
            login(user)
            visit(visit_path)
            fill_in 'name', with: name
            fill_in 'description', with: description
            click_button 'タスクを更新'
            expect(page).to have_current_path visit_path
          end
        end

        context 'タスク内容未記入' do
          let(:name) { 'タスクの名前変更' }
          let(:description) { '' }

          it 'エラーが表示されること' do
            login(user)
            visit(visit_path)
            fill_in 'name', with: name
            fill_in 'description', with: description
            click_button 'タスクを更新'
            expect(page).to have_content "タスクの説明を入力してください"
          end

          it 'ページ遷移しないこと' do
            login(user)
            visit(visit_path)
            fill_in 'name', with: name
            fill_in 'description', with: description
            click_button 'タスクを更新'
            expect(page).to have_current_path visit_path
          end
        end
      end

      context '他のユーザーのタスク' do
        let(:visit_path) { "/tasks/#{task.id}/edit" }
        let(:user) { create(:user) }
        let!(:task) { create(:task, user: create(:user, :other)) }

        it 'エラーメッセージが表示されること' do
          login(user)
          visit(visit_path)
          expect(page).to have_text('見つかりませんでした。')
        end

        it 'フォームが表示されないこと' do
          login(user)
          visit(visit_path)
          expect(page).not_to have_field('name')
        end
      end
    end
  end
end
