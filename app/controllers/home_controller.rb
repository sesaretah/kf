class HomeController < ApplicationController
  before_action :load_business, only: [:index]

  def index
  end

  def settings

  end
end
