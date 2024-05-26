# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :check_logged_in, only: :home

  def home; end

  def after_login; end
end
