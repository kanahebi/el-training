require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#validate' do
    subject { described_class.new(params) }

    let(:name) { 'Name' }
    let(:description) { 'Description' }
    let(:params) {
      {
        name: name,
        description: description,
      }
    }

    it { is_expected.to be_valid }

    context 'nameが空' do
      let(:name) { '' }

      it { is_expected.to be_invalid }
    end

    context 'descriptionが空' do
      let(:description) { '' }

      it { is_expected.to be_invalid }
    end
  end
end
