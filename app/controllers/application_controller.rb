class ApplicationController < ActionController::Base
  
  before_action :set_locale
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
    flash[:alert] = t("not_authorized")
    redirect_back(fallback_location: authenticated_root_path)
  end

  
  def set_timezone(&block) 
    Time.use_zone(current_user.timezone, &block) 
  end
  
  def set_locale 
    if user_signed_in?
      I18n.locale = current_user.language || I18n.default_locale
    else
      I18n.locale = params[:lang] || locale_from_header || I18n.default_locale
    end
  end

  
  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end
  
  def after_sign_out_path_for(resorce_or_scope)
    if I18n.locale == :es
      new_user_session_path(params: {lang: "es"})
    else
      new_user_session_path
    end
  end

end
