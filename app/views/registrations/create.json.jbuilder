json.status('created')
json.logged_in(true)
json.user do
  json.call(@user, :id, :email, :created_at, :updated_at)
end
