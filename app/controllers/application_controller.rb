class ApplicationController < ActionController::Base
  around_action :set_timezone, if: :current_user
  include Pundit::Authorization

  #skip_forgery_protection
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :calendar
  after_action :verify_authorized, unless: :devise_controller?
  skip_after_action :verify_authorized, only: :serve

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  def set_timezone(&block) 
    Time.use_zone(current_user.timezone, &block) 
  end

end
