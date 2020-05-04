# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'valid_label' do
    context "when to set the facorybot" do
      let(:label) { build :label }
      it { is_expected.to be_valid }
    end
  end
end
