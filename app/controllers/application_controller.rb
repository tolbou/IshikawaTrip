# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :check_logged_in

  def check_logged_in
    Rails.logger.info "ログインチェック: #{current_user.inspect}"
    return if current_user

    allowed_paths = [posts_path, root_path, before_login_path]
    allowed_paths << post_path(params[:id]) if params[:id].present?

    unless allowed_paths.include?(request.path) || request.path.match?(/\/posts\/\d+/)
      redirect_to before_login_path
    end
  end
end
