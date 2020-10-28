crumb :root do
  link "One Task", root_path
end

crumb :tasks do
  link "One Task", tasks_path
end

crumb :mypage do
  link "タスク状況", each_user_path
end

crumb :task_show do
  link "Your Task", task_path
end

crumb :task_new do
  link "Create Your Task", new_task_path
end

crumb :task_edit do
  link "Update Your Task", edit_task_path
end

crumb :admin_user_index do
  link "Users Table", admin_users_path
end

crumb :admin_user_show do
  link "User Page", admin_user_path
  parent :admin_user_index
end

crumb :admin_user_new do
  link "Create User", new_admin_user_path
  parent :admin_user_index
end

crumb :admin_user_edit do
  link "Edit User", edit_admin_user_path
  parent :admin_user_index
end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
