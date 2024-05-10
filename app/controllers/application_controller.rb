class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :check_logged_in

    def check_logged_in
        Rails.logger.info "ログインチェック: #{current_user.inspect}"
        return if current_user

        redirect_to root_path
    end
end
