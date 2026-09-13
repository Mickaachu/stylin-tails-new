module Admin
  class AvailabilitiesController < BaseController
    def index
      @availabilities = Availability.where("available_on >= ?", Date.current).order(:available_on, :starts_at)
      @availability = Availability.new(interval_minutes: 30, active: true)
    end

    def create
      @availability = Availability.new(availability_params)

      if @availability.save
        redirect_to admin_availabilities_path, notice: "Availability added to the schedule."
      else
        @availabilities = Availability.where("available_on >= ?", Date.current).order(:available_on, :starts_at)
        render :index, status: :unprocessable_content
      end
    end

    def destroy
      Availability.find(params.expect(:id)).destroy!
      redirect_to admin_availabilities_path, notice: "Availability removed from the schedule.", status: :see_other
    end

    private

    def availability_params
      params.expect(availability: [ :available_on, :starts_at, :ends_at, :interval_minutes, :active ])
    end
  end
end
