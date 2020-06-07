class SidekiqJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Sidekiq::Logging.logger.info "ジョブを実行しました！"
  end
end
