user = User.find_by(email: 'user1@example.com')
Task.where(user_id: nil).update_all(user_id: user.id)
