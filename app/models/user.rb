class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :owner, dependent: :destroy
  enum :role, { user: 0, admin: 1 }
  after_create_commit :create_owner_profile

  private
  def create_owner_profile
    create_owner!(email: email) if user?
  end
end
