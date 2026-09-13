module Admin
  class OwnersController < BaseController
    before_action :set_owner, only: %i[show edit update destroy]

    def index
      @owners = Owner.customer_profiles.includes(:user, :pets).order(:full_name, :email)
    end

    def show
      @appointments = Appointment.where(owner: @owner).includes(:pet).order(date_time: :desc)
    end

    def new
      @owner = Owner.new
      load_users
    end

    def edit
      load_users
    end

    def create
      @owner = Owner.new(owner_params)
      if @owner.save
        redirect_to admin_owner_path(@owner), notice: "Customer created successfully."
      else
        load_users
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @owner.update(owner_params)
        redirect_to admin_owner_path(@owner), notice: "Customer updated successfully."
      else
        load_users
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @owner.destroy!
      redirect_to admin_owners_path, notice: "Customer deleted.", status: :see_other
    end

    private

    def set_owner
      @owner = Owner.customer_profiles.includes(:pets, :user).find(params.expect(:id))
    end

    def load_users
      @users = User.user.order(:email)
    end

    def owner_params
      params.expect(owner: [ :full_name, :phone, :email, :user_id ])
    end
  end
end
