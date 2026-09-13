class Owner < ApplicationRecord
  belongs_to :user
  has_many :pets, dependent: :destroy
  has_many :appointments, dependent: :destroy
  scope :customer_profiles, -> { joins(:user).where.not(users: { role: User.roles[:admin] }) }
end
