class AddOwnerToPets < ActiveRecord::Migration[8.1]
  def change
    add_reference :pets, :owner, null: false, foreign_key: true
  end
end
