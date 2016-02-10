class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Devise::Controllers::Helpers
  protect_from_forgery with: :null_session
  before_action :authenticate_api_user!
end
