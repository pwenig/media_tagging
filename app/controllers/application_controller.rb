class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    # If the user is an admin, send them to the admin dashboard.
    if current_user && current_user.admin
      admin_root_path
    else
      root_path
    end
  end
end
