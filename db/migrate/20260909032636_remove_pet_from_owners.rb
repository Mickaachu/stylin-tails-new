class RemovePetFromOwners < ActiveRecord::Migration[8.1]
  def change
    remove_reference :owners, :pet, null: false, foreign_key: true
  end
end
