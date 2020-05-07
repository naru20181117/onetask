# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  subject { label }
  describe 'valid_label' do
    context "when to set the facorybot" do
      let(:label) { build :label }
      it { is_expected.to be_valid }
    end
  end

  describe 'invalid_label' do
    context 'when the name is nil' do
      let(:label) { build :label, name: nil }
      it "is invalid" do
        is_expected.to be_invalid
      end
    end
  end
end
