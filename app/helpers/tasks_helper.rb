# frozen_string_literal: true

module TasksHelper
  def created_at_sub
    params[:sort_column] == "created_at" ? '登録日時▼' : '登録日時△'
  end

  def end_time_sub
    params[:sort_column] == "end_time" ? '終了期限▼' : '終了期限△'
  end

  def search_content_params
    params["search"].present? ? params["search"]["content"] : nil
  end

  def search_status_params
    params["search"].present? ? params["search"]["status"] : nil
  end
end
