json.logged_in(true)
json.user do
  json.call(@current_user, :id, :email)
end
