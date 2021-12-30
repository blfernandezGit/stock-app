class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception, prepend: true

    add_flash_types :danger

    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(_resource)
        if current_user.admin?
            client_list_path
        else
            inventories_path
        end
    end

    protected

        def authenticate_admin!
            authenticate_user!
            redirect_to root_path, status: :forbidden unless current_user.admin?
        end

        def authenticate_client!
            authenticate_user!
            redirect_to client_list_path, status: :forbidden unless !current_user.admin?
        end

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:full_name, :role, :status, :email, :password, :password_confirmation)}

            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:full_name, :email, :password, :current_password, :reset_password_token)}
        end

end
