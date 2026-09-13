class ContactController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    @name = params[:name].to_s.strip
    @email = params[:email].to_s.strip
    @message = params[:message].to_s.strip

    if @name.present? && @email.present? && @message.present?
      redirect_to contact_path, notice: "Thanks, #{@name}. Our team will be in touch soon."
    else
      flash.now[:alert] = "Please complete your name, email, and message."
      render :new, status: :unprocessable_content
    end
  end
end
