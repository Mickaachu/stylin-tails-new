class Availability < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :future, -> { where("available_on >= ?", Date.current) }

  validates :available_on, :starts_at, :ends_at, :interval_minutes, presence: true
  validates :interval_minutes, numericality: { only_integer: true, greater_than: 0 }
  validate :ends_after_start

  def slots
    start_seconds = starts_at.seconds_since_midnight
    end_seconds = ends_at.seconds_since_midnight
    interval_seconds = interval_minutes.to_i.minutes.to_i

    (0...((end_seconds - start_seconds) / interval_seconds)).map do |index|
      Time.zone.local(available_on.year, available_on.month, available_on.day) + start_seconds + (index * interval_seconds)
    end
  end

  def self.slot_available?(date_time)
    return false unless date_time

    active.any? do |availability|
      availability.available_on == date_time.to_date && availability.slots.any? { |slot| slot == date_time.change(sec: 0) }
    end
  end

  private

  def ends_after_start
    return if starts_at.blank? || ends_at.blank? || ends_at > starts_at

    errors.add(:ends_at, "must be after the start time")
  end
end
