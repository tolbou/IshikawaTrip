module SessionsHelper
    def current_user
        return unless (user_id = session[:user_id])
        Rails.logger.debug "現在のユーザーID: #{user_id}"
        @current_user ||= User.find_by(id: user_id)
    end

    def log_in(user)
        session[:user_id] = user.id
        Rails.logger.info "セッションをセット: #{session[:user_id]}"
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
