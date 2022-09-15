user1 = User.find_by(email: 'user1@example.com')
user2 = User.find_by(email: 'user2@example.com')

20.times do |i|
  Task.seed(:name) do |s|
    s.user_id = user1.id
    s.name = "#{user1.name}のタスク#{i+1}"
    s.description = "#{user1.name}のタスク#{i+1}の内容"
  end
  Task.seed(:name) do |s|
    s.user_id = user2.id
    s.name = "#{user2.name}のタスク#{i+1}"
    s.description = "#{user2.name}のタスク#{i+1}の内容"
  end
end
