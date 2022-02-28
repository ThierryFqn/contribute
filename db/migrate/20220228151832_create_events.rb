class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :cause
      t.integer :status, default: 0
      t.datetime :start_date
      t.datetime :end_date
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :number_volunteers
      t.references :asso, null: false, foreign_key: true

      t.timestamps
    end
  end
end
