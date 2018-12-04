class HomeController < ApplicationController
  before_action :load_business, only: [:index, :settings]

  def index
  end

  def settings

  end
end
