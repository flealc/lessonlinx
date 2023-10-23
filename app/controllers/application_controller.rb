class ApplicationController < ActionController::Base
  #skip_forgery_protection
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :calendar
end
