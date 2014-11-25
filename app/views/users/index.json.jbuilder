json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :password_hash, :password_salt
  json.url user_url(user, format: :json)
end
