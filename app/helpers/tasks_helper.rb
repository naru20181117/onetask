# frozen_string_literal: true

module TasksHelper
  def created_at_sub
    params[:sort_column] == "created_at" ? '登録日時▼' : '登録日時△'
  end

  def end_time_sub
    params[:sort_column] == "end_time" ? '終了期限▼' : '終了期限△'
  end

  def priority_sub
    params[:sort_column] == "priority" ? '優先度▼' : '優先度△'
  end
end
