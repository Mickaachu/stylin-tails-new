class ProfileController < ApplicationController
  def show
    @owner = current_user.owner
    @pets = @owner&.pets&.order(:name) || Pet.none
    @appointments = @owner&.appointments&.includes(:pet)&.order(date_time: :desc)&.limit(5) || Appointment.none
  end
end
