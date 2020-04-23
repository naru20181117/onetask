# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }
  describe 'valid_user' do
    context "when the name is present" do
      let!(:user) { build :user }
      it { is_expected.to be_valid }
    end
  end

  describe 'invalid_user' do
    context "when the name is nil" do
      let(:user) { build :user, name: nil }
      it { is_expected.to be_invalid }
    end

    context "when the email is nil" do
      let(:user) { build :user, email: nil }
      it { is_expected.to be_invalid }
    end

    context "when the password is nil" do
      let(:user) { build :user, password: nil }
      it { is_expected.to be_invalid }
    end
  end
end
