User.seed(:email) do |s|
  s.name = 'ユーザー太郎'
  s.email = "user1@example.com"
  s.password = "password"
end

User.seed(:email) do |s|
  s.name = 'ユーザー二郎'
  s.email = "user2@example.com"
  s.password = "password"
end
