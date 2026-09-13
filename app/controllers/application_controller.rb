class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  before_action :ensure_owner_profile, if: -> { current_user.present? && !current_user.admin? }

  private

  def ensure_owner_profile
    return unless current_user

    current_user.owner || current_user.create_owner!(email: current_user.email)
  end

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_root_path : dashboard_path
  end

  def after_sign_up_path_for(resource)
    resource.admin? ? admin_root_path : settings_path(onboarding: true)
  end
end
