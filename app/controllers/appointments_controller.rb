class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]
  before_action :set_available_pets, only: %i[ new edit create update ]
  before_action :set_availabilities, only: %i[ new edit create update ]

  # GET /appointments or /appointments.json
  def index
    @appointments = current_user.admin? ? Appointment.all : current_user.owner.appointments
  end

  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new(owner: current_user.owner, status: "requested")
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.owner = current_user.owner
    @appointment.status = "requested"

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @appointment.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: "Appointment was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @appointment.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy!

    respond_to do |format|
      format.html { redirect_to appointments_path, notice: "Appointment was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      scope = current_user.admin? ? Appointment.all : current_user.owner.appointments
      @appointment = scope.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.expect(appointment: [ :service, :date_time, :pet_id ])
    end

    def set_available_pets
      @pets = current_user.owner&.pets || Pet.none
    end

    def set_availabilities
      @availabilities = Availability.active.future.order(:available_on, :starts_at)
    end
end
