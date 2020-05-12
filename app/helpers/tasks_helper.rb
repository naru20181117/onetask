# frozen_string_literal: true

module TasksHelper
  def created_at_sub
    params[:sort_column] == "created_at" ? '作成順▼' : '作成順△'
  end

  def end_time_sub
    params[:sort_column] == "end_time" ? '終了期限▼' : '終了期限△'
  end

  def status_sub
    params[:sort_column] == "status" ? 'ステータス▼' : 'ステータス△'
  end

  def priority_sub
    params[:sort_column] == "priority" ? '優先度▼' : '優先度△'
  end

  def end_time_color(task)
    time = task.end_time
    if task.status == 'done'
      "bg-secondary"
    elsif time <= Time.zone.today + 3.days || (time <= Time.zone.today + 5.days && task.priority == "high")
      "bg-danger"
    elsif time <= Time.zone.today + 5.days || (time <= Time.zone.today + 8.days && task.priority == "high")
      "bg-warning"
    elsif task.status == 'wip'
      "bg-info"
    end
  end

  def hidden_fire(task)
    if task.status == 'done' || task.end_time > Time.zone.today + 5.days
      "d-none"
    end
  end

  def hidden_primary(task)
    if task.status == 'done' || task.priority != 'high'
      "d-none"
    end
  end
end
