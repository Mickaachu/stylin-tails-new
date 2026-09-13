class Appointment < ApplicationRecord
  SERVICE_PRICES = {
    "Full Grooming Session" => 75,
    "Bath & Blowout" => 45,
    "Nail Care & File" => 20
  }.freeze

  attr_accessor :admin_managed
  belongs_to :pet
  belongs_to :owner

  before_validation :set_cost_from_service
  validate :pet_belongs_to_owner
  validate :date_time_is_available, if: -> { date_time.present? && !admin_managed }

  private

  def date_time_is_available
    return if Availability.slot_available?(date_time)

    errors.add(:date_time, "must use an available appointment slot")
  end

  def set_cost_from_service
    self.cost = SERVICE_PRICES[service] if SERVICE_PRICES.key?(service)
  end

  def pet_belongs_to_owner
    return if pet.blank? || owner.blank? || pet.owner_id == owner_id

    errors.add(:pet, "must belong to the selected owner")
  end
end
