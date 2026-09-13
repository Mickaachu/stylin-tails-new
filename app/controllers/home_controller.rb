class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  skip_before_action :ensure_owner_profile, only: [ :index ]

  def index
  end
end
