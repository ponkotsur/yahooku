json.array!(@users) do |user|
  json.extract! user, :id, :id, :pass, :nickname, :email
  json.url user_url(user, format: :json)
end
