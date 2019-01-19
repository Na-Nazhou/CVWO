class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  around_action :set_time_zone

  def set_time_zone(&block)
    time_zone = current_user.try(:time_zone) || 'UTC'
    Time.use_zone(time_zone, &block)
  end
end
