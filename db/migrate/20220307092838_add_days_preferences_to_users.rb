class AddDaysPreferencesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :days_preferences, :string
  end
end
