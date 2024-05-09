class SessionsController < ApplicationController
    skip_before_action :check_logged_in, only: :create

    def create
        user = User.find_or_create_from_auth_hash(auth_hash)
        if user.persisted?
            log_in(user)
            Rails.logger.debug "ログインユーザー: #{user.id}, セッション: #{session[:user_id]}"
            redirect_to root_path, notice: 'ログインに成功しました。'
        else
            redirect_to root_path, alert: 'ログインに失敗しました。'
        end
    end

    def destroy
        log_out
        redirect_to root_path
    end

    private

    def auth_hash
        request.env['omniauth.auth']
    end
end
