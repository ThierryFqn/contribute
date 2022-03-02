class AddNumberOfHoursToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :number_hours, :integer
  end
end
