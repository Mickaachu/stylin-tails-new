class CreateOwners < ActiveRecord::Migration[8.1]
  def change
    create_table :owners do |t|
      t.string :full_name
      t.string :phone
      t.string :email
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
