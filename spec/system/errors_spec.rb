# frozen_string_literal: true

require 'rails_helper'
RSpec.describe "Errors", js: true, type: :system do
  describe '403' do
    before { sign_in }
    let(:login_user) { create :user, admin: false }
    context 'when you get Forbidden error' do
      before { visit admin_users_path }
      it 'shows 403 page' do
        expect(page).to have_content("403 Forbidden")
      end
    end
  end

  describe '404' do
    context 'when you get to none existed page' do
      before { visit '/404test' }
      it 'shows 404 page' do
        expect(page).to have_selector '.error_description', text: 'Page　Not　Found'
      end
    end
  end
  describe '500' do
    context 'when you get internal server error' do
      before do
        allow_any_instance_of(SessionsController).to receive(:new).and_throw(StandardError)
        visit login_path
      end
      it 'shows 500 page' do
        expect(page).to have_selector '.error_description', text: 'Internal　Server　Error'
      end
    end
  end
end
