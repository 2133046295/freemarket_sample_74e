class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :set_category

  EXHIBITING_STATUS = 1
  BUYING_STATUS = 2
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_user_login
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_year, :birth_month, :birth_day, :email, :password])
  end

  private

  def production?
    Rails.env.production?
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  protected
  def set_category
    @parents  = Category.where(ancestry: nil)
  end
end
