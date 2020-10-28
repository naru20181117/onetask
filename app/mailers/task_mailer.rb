class TaskMailer < ApplicationMailer
  default from: 'taskleaf@example.com'

  def creation_email(task, current_user)
    @task = task
    @current_user = current_user
    mail(
      subject: 'Taskリマインドメール',
      to: current_user.email,
      from: 'taskleaf@example.com'
    )
  end
end
