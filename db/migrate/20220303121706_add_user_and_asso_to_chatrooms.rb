class AddUserAndAssoToChatrooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :chatrooms, :user, foreign_key: true
    add_reference :chatrooms, :asso, foreign_key: true
  end
end
