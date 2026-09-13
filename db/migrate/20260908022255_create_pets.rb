class CreatePets < ActiveRecord::Migration[8.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :breed
      t.string :size
      t.string :notes

      t.timestamps
    end
  end
end
