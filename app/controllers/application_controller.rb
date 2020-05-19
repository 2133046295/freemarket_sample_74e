class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :set_category

  EXHIBITING_STATUS = 1
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_year, :birth_month, :birth_day, :email, :password])
  end

  private

  def production?
    Rails.env.production?
  end

  private
  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
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
