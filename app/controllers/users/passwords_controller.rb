class Users::PasswordsController < Devise::PasswordsController
  
  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    if params[:lang] == "es"
      new_user_session_path(params: {lang: "es"})
    else
      new_user_session_path
    end
  end

  def after_resetting_password_path_for(resource)
    if params[:lang] == "es"
      new_user_session_path(params: {lang: "es"})
    else
      new_user_session_path
    end
  end


end
  
