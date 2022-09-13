require 'rails_helper'

RSpec.describe 'ListTask', type: :system, js: true do
  describe 'タスク一覧' do
    describe 'ログインしていない' do
      let(:visit_path) { "/tasks" }

      it 'ログインページに遷移すること' do
        visit(visit_path)
        expect(page).to have_current_path "/login"
      end
    end

    describe 'ログイン済み' do
      context '自分のタスク' do
        let(:visit_path) { "/tasks" }
        let(:user) { create(:user) }

        context 'タスクが存在する場合' do
          let!(:task) { create(:task, user:) }

          it 'タスクの名前が表示されている' do
            login(user)
            visit(visit_path)
            expect(page).to have_text(task.name)
          end
        end

        context 'タスクが存在しない場合' do
          it 'タスクがない旨が表示されている' do
            login(user)
            visit(visit_path)
            expect(page).to have_text('タスクはありません。')
          end
        end

        context '並び順' do
          let!(:task1) { create(:task, name: 'タスク1', user:) }
          let!(:task2) { create(:task, name: 'タスク2', user:) }

          it '作成日時の降順で表示されている' do
            login(user)
            visit(visit_path)
            expect(page.text).to match(/#{task2.name}[\s\S]*#{task1.name}/)
          end
        end
      end

      context '他のユーザーのタスク' do
        let(:visit_path) { "/tasks" }
        let(:user) { create(:user) }
        let!(:task) { create(:task, name: '他のユーザーのタスク', user: create(:user, :other)) }

        it '表示されないこと' do
          login(user)
          visit(visit_path)
          expect(page).not_to have_text(task.name)
        end
      end
    end
  end
end
