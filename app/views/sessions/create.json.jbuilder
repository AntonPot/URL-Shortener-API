json.status('created')
json.logged_in(true)
json.user do
  json.call(@user, :id, :email)
end
