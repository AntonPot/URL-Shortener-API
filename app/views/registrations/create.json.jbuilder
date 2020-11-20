json.status('created')
json.user do
  json.call(@user, :id, :email, :created_at, :updated_at)
end
