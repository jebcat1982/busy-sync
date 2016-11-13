require "#{Rails.root}/lib/google_calendar_wrapper"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?#, :current_user_calendar

  def not_found
    render :file => 'public/404.html', :status => 404, :layout => false
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def current_user_calendar
  #   ::GoogleCalendarWrapper.new(current_user)
  # end

  def signed_in?
    current_user.present?
  end
end
