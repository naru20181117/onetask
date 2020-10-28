# frozen_string_literal: true

require "rails_helper"
RSpec.describe TaskMailer, type: :mailer do
  let(:user_a) { create :user }
  let(:task) { create :task, name: 'メイラー', user: user_a }

  let(:html_body) do
    mail.body.raw_source
  end

  describe '#creation_email' do
    let(:mail){ TaskMailer.creation_email(task) }

    it 'can send email correctly' do
      expect(mail.subject).to eq('タスク作成完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['taskleaf@example.com'])

      expect(html_body).to match('以下のタスクを作成しました')
    end
  end
end
