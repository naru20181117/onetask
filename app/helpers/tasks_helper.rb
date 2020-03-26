# frozen_string_literal: true

module TasksHelper
  def created_at_sub
    params[:created_at].present? ? '登録日時▼' : '登録日時△'
  end

  def end_time_sub
    params[:end_time].present? ? '終了期限▼' : '終了期限△'
  end
end
