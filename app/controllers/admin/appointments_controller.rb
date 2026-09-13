module Admin
  class AppointmentsController < BaseController
    before_action :set_appointment, only: %i[show edit update destroy approve reject]

    def index
      @appointments = Appointment.includes(:owner, :pet).order(date_time: :asc)
    end

    def show
    end

    def new
      @appointment = Appointment.new
      load_form_options
    end

    def edit
      load_form_options
    end

    def create
      @appointment = Appointment.new(appointment_params)
      @appointment.admin_managed = true
      if @appointment.save
        redirect_to admin_appointment_path(@appointment), notice: "Appointment created successfully."
      else
        load_form_options
        render :new, status: :unprocessable_content
      end
    end

    def update
      @appointment.admin_managed = true
      if @appointment.update(appointment_params)
        redirect_to admin_appointment_path(@appointment), notice: "Appointment updated successfully."
      else
        load_form_options
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @appointment.destroy!
      redirect_to admin_appointments_path, notice: "Appointment deleted.", status: :see_other
    end

    def approve
      update_status("confirmed", "Appointment approved.")
    end

    def reject
      update_status("rejected", "Appointment rejected.")
    end

    private

    def update_status(status, notice)
      @appointment.update!(status: status)
      redirect_to admin_appointments_path, notice: notice
    end

    def set_appointment
      @appointment = Appointment.includes(:owner, :pet).find(params.expect(:id))
    end

    def load_form_options
      @owners = Owner.customer_profiles.order(:full_name, :email)
      @pets = Pet.includes(:owner).order(:name)
    end

    def appointment_params
      params.expect(appointment: [ :service, :date_time, :pet_id, :owner_id, :cost, :status ])
    end
  end
end
