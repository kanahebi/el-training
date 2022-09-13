require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validate' do
    subject { described_class.new(params) }

    let(:name) { 'Name' }
    let(:email) { 'user@example.com' }
    let(:password) { 'password' }
    let(:params) do
      {
        name:,
        email:,
        password:
      }
    end

    it { is_expected.to be_valid }
  end

  describe '#password_digest' do
    subject do
      user = described_class.create(params)
      user.password_digest
    end

    let(:name) { 'Name' }
    let(:email) { 'user@example.com' }
    let(:password) { 'password' }
    let(:params) do
      {
        name:,
        email:,
        password:
      }
    end

    it '入力したパスワードがハッシュ化されていること' do
      expect(subject).not_to eq(password)
    end
  end

  describe '#password' do
    subject do
      described_class.find(id).password
    end

    let(:user) { create(:user, password:) }
    let(:id) { user.id }
    let(:password) { 'password' }

    it 'パスワードが取得できないこと' do
      expect(subject).to be_blank
    end
  end
end
