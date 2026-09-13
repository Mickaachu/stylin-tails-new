class ServicesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @services = Appointment::SERVICE_PRICES
  end
end
