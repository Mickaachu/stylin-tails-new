class CreateAppointments < ActiveRecord::Migration[8.1]
  def change
    create_table :appointments do |t|
      t.string :service
      t.datetime :date_time
      t.references :pet, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: true
      t.decimal :cost
      t.string :status

      t.timestamps
    end
  end
end
