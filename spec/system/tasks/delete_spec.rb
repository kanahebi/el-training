require 'rails_helper'

RSpec.describe 'DeleteTask', type: :system, js: true do
  describe 'タスク削除' do
    describe 'ログインしていない' do
      let(:visit_path) { "/tasks/#{task.id}" }
      let(:task) { create(:task, user: create(:user)) }

      it 'ログインページに遷移すること' do
        visit(visit_path)
        expect(page).to have_current_path "/login"
      end
    end

    describe 'ログイン済み' do
      context '削除ボタン押下' do
        let(:visit_path) { "/tasks/#{id}" }
        let(:user) { create(:user) }
        let(:task) { create(:task, user:) }
        let(:id) { task.id }

        it '確認ダイアログが出てくること' do
          login(user)
          visit(visit_path)
          click_button '削除'

          expect(page).to have_text('本当に削除しますか？')
        end

        it '確認ダイアログで削除を押下したら削除できること', :aggregate_failures do
          login(user)
          visit(visit_path)
          click_button '削除'
          find(".deleteButton").click

          expect(page).to have_current_path "/tasks"
          expect(Task.find_by(id:)).to be_blank
        end

        it '確認ダイアログでキャンセルを押下したらダイアログを閉じること', :aggregate_failures do
          login(user)
          visit(visit_path)
          click_button '削除'
          click_button 'キャンセル'

          expect(page).not_to have_text('本当に削除しますか？')
          expect(page).to have_current_path visit_path
          expect(Task.find_by(id:)).to eq(task)
        end
      end
    end
  end
end
