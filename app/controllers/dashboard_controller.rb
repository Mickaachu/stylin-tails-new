class DashboardController < ApplicationController
  def index
    @owner = current_user.owner
    @pets = @owner&.pets&.order(:name) || Pet.none
    appointments = @owner ? @owner.appointments.includes(:pet) : Appointment.none
    @next_appointment = appointments.where("date_time >= ?", Time.current).order(:date_time).first
    @recent_appointments = appointments.where.not(id: @next_appointment&.id).order(date_time: :desc).limit(5)
  end
end
