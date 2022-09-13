require 'rails_helper'

RSpec.describe 'Session', type: :system, js: true do
  describe 'ログイン' do
    let(:visit_path) { "/login" }
    let(:user) { create(:user, password:) }
    let(:password) { 'password' }

    context '正しいメールアドレスとパスワードを入力' do
      it 'ログインできること' do
        visit visit_path
        fill_in 'email', with: user.email
        fill_in 'password', with: password
        click_button 'ログイン'

        expect(page).to have_text('ログインしました。')
      end
    end

    context 'メールアドレスが空' do
      it 'エラーが表示されること' do
        visit visit_path
        fill_in 'email', with: ''
        fill_in 'password', with: password
        click_button 'ログイン'

        expect(page).to have_text('ログインできませんでした。')
      end
    end

    context 'パスワードが空' do
      it 'エラーが表示されること' do
        visit visit_path
        fill_in 'email', with: user.email
        fill_in 'password', with: ''
        click_button 'ログイン'

        expect(page).to have_text('ログインできませんでした。')
      end
    end

    context 'ログイン前にログインが必要なページにアクセス' do
      let(:visit_before_login) { '/tasks/new' }

      it 'ログイン後に該当ページへリダイレクトすること' do
        visit visit_before_login
        fill_in 'email', with: user.email
        fill_in 'password', with: password
        click_button 'ログイン'

        expect(page).to have_current_path visit_before_login
      end
    end
  end

  describe 'ログアウト' do
    context 'ログアウトを押下' do
      let(:user) { create(:user) }

      it 'ログアウトできること' do
        login(user)
        click_button 'ログアウト'

        expect(page).to have_current_path '/login'
      end
    end
  end
end
