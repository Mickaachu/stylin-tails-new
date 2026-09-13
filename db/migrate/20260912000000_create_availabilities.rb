class CreateAvailabilities < ActiveRecord::Migration[8.1]
  def change
    create_table :availabilities do |t|
      t.date :available_on, null: false
      t.time :starts_at, null: false
      t.time :ends_at, null: false
      t.integer :interval_minutes, null: false, default: 30
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :availabilities, :available_on
  end
end
