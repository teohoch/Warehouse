class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :to_boolean

  def to_boolean(s)
    !!(s =~ /^(true|t|yes|y|1)$/i)
  end
end
