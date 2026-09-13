module Admin
  class PetsController < BaseController
    before_action :set_pet, only: %i[show edit update destroy]

    def index
      @pets = Pet.includes(:owner).order(:name)
    end

    def show
      @appointments = Appointment.where(pet: @pet).order(date_time: :desc)
    end

    def new
      @pet = Pet.new
      load_owners
    end

    def edit
      load_owners
    end

    def create
      @pet = Pet.new(pet_params)
      if @pet.save
        redirect_to admin_pet_path(@pet), notice: "Pet created successfully."
      else
        load_owners
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @pet.update(pet_params)
        redirect_to admin_pet_path(@pet), notice: "Pet updated successfully."
      else
        load_owners
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @pet.destroy!
      redirect_to admin_pets_path, notice: "Pet deleted.", status: :see_other
    end

    private

    def set_pet
      @pet = Pet.find(params.expect(:id))
    end

    def load_owners
      @owners = Owner.customer_profiles.order(:full_name, :email)
    end

    def pet_params
      params.expect(pet: [ :name, :breed, :size, :notes, :owner_id ])
    end
  end
end
