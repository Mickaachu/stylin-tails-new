class SettingsController < ApplicationController
  before_action :require_member!

  def show
    @owner = current_user.owner || current_user.create_owner!(email: current_user.email)
  end

  def update
    @owner = current_user.owner || current_user.create_owner!(email: current_user.email)
    attributes = settings_params

    User.transaction do
      current_user.update!(email: attributes[:email])
      @owner.update!(full_name: attributes[:full_name], phone: attributes[:phone], email: attributes[:email])
    end

    redirect_to dashboard_path, notice: "Your profile was updated successfully."
  rescue ActiveRecord::RecordInvalid
    render :show, status: :unprocessable_content
  end

  private

  def settings_params
    params.expect(settings: [ :full_name, :phone, :email ])
  end

  def require_member!
    redirect_to admin_root_path if current_user.admin?
  end
end
