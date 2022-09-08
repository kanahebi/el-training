class AddColumnUserIdToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :user, type: :uuid, foreign_key: true
  end
end
