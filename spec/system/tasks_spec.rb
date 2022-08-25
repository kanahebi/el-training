require 'rails_helper'

RSpec.describe Task, type: :system, js: true do
  describe 'CRUD' do
    describe 'タスク一覧' do
      before do
        visit('/tasks')
      end

      context 'タスクが存在する場合' do
        let!(:task) { create(:task) }

        it 'タスクの名前が表示されている' do
          expect(page).to have_text(task.name)
        end
      end

      context 'タスクが存在しない場合' do
        it 'タスクがない旨が表示されている' do
          expect(page).to have_text('タスクはありません。')
        end
      end
    end

    describe 'タスク詳細' do
      let(:task) { create(:task) }

      before do
        visit("/tasks/#{task.id}")
      end

      it 'タスクの名前が表示されている' do
        expect(page).to have_text(task.name)
      end

      it 'タスクの説明が表示されている' do
        expect(page).to have_text(task.description)
      end
    end

    describe 'タスク作成' do
      before do
        visit("/tasks/new")
        fill_in 'name', with: name
        fill_in 'description', with: description
        click_button 'タスクを追加'
      end

      let(:task_count) { described_class.count }
      let(:name) { 'タスクの名前' }
      let(:description) { 'タスクの説明' }

      context 'フォームの入力値が正常' do
        it 'タスク詳細ページに遷移すること' do
          expect(page).to have_no_current_path "/tasks/new"
        end
      end

      context 'タスク名未記入' do
        let(:name) { '' }

        it 'エラーが表示されること' do
          expect(page).to have_content "タスクの名前を入力してください"
        end

        it 'ページ遷移しないこと' do
          expect(page).to have_current_path "/tasks/new"
        end
      end

      context 'タスク内容未記入' do
        let(:description) { '' }

        it 'エラーが表示されること' do
          expect(page).to have_content "タスクの説明を入力してください"
        end

        it 'ページ遷移しないこと' do
          expect(page).to have_current_path "/tasks/new"
        end
      end
    end
  end
end
