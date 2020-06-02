class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    added_attrs = [:user_name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "LogIn is done successfully"
      books_path  #　指定したいパスに変更
    else
      flash[:notice] = "error to LogIn"
      new_user_session  #　指定したいパスに変更
    end
  end

  def after_sign_up_path_for(resource)
    if current_user
      flash[:notice] = "SignUp is done successfully"
      books_path  #　指定したいパスに変更
    else
      flash[:notice] = "error to SignUp"
      new_user_session  #　指定したいパスに変更
    end
  end
end
