# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  it 'js test' do
    visit tasks_path
    click_button('Delete')
    expect(page.driver.browser.switch_to.notice.text).to eq 'Are you sure you wanna delete this?'
    page.accept_confirm
  end
end
