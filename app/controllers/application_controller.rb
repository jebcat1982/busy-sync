require "#{Rails.root}/lib/google_calendar_wrapper"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def not_found
    render :file => 'public/404.html', :status => 404, :layout => false
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  def personal_signed_in?
    signed_in? && current_user.personal_email.present?
  end
  helper_method :personal_signed_in?

  def business_signed_in?
    signed_in? && current_user.business_email.present?
  end
  helper_method :business_signed_in?

  # TODO: get a better image
  def blank_image_url
    "data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22200%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20200%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_15905202c1c%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_15905202c1c%22%3E%3Crect%20width%3D%22200%22%20height%3D%22200%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2274.4296875%22%20y%3D%22104.5%22%3E200x200%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
  end

  def personal_img_src
    if personal_signed_in?
      current_user.personal_image
    else
      blank_image_url
    end
  end
  helper_method :personal_img_src

  # TODO: lmao all of this is shameful
  def personal_caption
    if personal_signed_in?
      """
      Signed in as <strong>#{current_user.personal_email}</strong>
      <a href='/logout'>Sign out</a>
      """
    else
      """
      <a href='/auth/google_oauth2'>Sign in with Google</a>
      """
    end.html_safe
  end
  helper_method :personal_caption

  def business_img_src
    if business_signed_in?
      current_user.business_image
    else
      blank_image_url
    end
  end
  helper_method :business_img_src

  def business_caption
    if business_signed_in?
      """
      Signed in as <strong>#{current_user.business_email}</strong>
      <a href='/logout'>Sign out</a>
      """
    else
      """
      <a href='/auth/google_oauth2'>Sign in with Google</a>
      """
    end.html_safe
  end
  helper_method :business_caption
end
