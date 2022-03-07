class AddCausesPreferencesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :causes_preferences, :string
  end
end
