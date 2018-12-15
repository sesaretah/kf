class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_action :load_business, only: [:index, :settings, :sales]

  def index
  end

  def settings
    @section = params[:section]
  end

  def sales
    @items = []
    shipping_costs
    taxation
  end

  def shipping_costs
    params.each do |name, value|
      if name =~ /province_(.+)$/
        @province = Province.find($1)
        @value = 0
        if !value.blank?
          @value = value
        end
        @items << {province: @province, cost: @value}
      end
    end
    for item in @items
      @shipping_cost = ShippingCost.where(business_id: @business.id, province_id: item[:province].id).first
      if @shipping_cost.blank?
        @shipping_cost = ShippingCost.create(business_id: @business.id, province_id: item[:province].id)
      end
      @shipping_cost.cost = item[:cost]
      @shipping_cost.save
    end
  end

  def taxation
    @taxation = Taxation.where(business_id: @business.id).first
    if @taxation.blank?
      @taxation = Taxation.create(business_id: @business.id)
    end
    @taxation.percent = params[:vat_percentage]
    @taxation.save
  end
end
