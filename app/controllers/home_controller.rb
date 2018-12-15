class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_action :load_business, only: [:index, :settings]

  def index
  end

  def settings
    @section = params[:section]
  end

  def sales
    @items = []
    params.each do |name, value|
      if name =~ /count_(.+)$/
        @province = Province.find($1)
        @items << {province: @province, cost: value}
      end
    end
  end
end
