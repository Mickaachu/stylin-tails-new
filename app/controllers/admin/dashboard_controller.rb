module Admin
  class DashboardController < BaseController
    def index
      @owners_count = Owner.customer_profiles.count
      @pets_count = Pet.count
      @appointments_count = Appointment.count
      @today_appointments = Appointment.includes(:owner, :pet).where(date_time: Time.current.beginning_of_day..Time.current.end_of_day).order(:date_time)
      @upcoming_appointments = Appointment.includes(:owner, :pet).where("date_time >= ?", Time.current).order(:date_time).limit(8)
      @pending_count = Appointment.where(status: [ "pending", "requested" ]).count
      @monthly_revenue = Appointment.where(date_time: Time.current.beginning_of_month..Time.current.end_of_month).sum(:cost)
      @recent_owners = Owner.customer_profiles.order(created_at: :desc).limit(3)
      @recent_activity = Appointment.includes(:owner, :pet).order(updated_at: :desc).limit(4)
    end
  end
end
