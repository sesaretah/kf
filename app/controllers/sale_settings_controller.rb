class SaleSettingsController < ApplicationController
  before_action :load_business, only: [:remote_switch]
  def remote_switch
    @sale_setting = @business.sale_setting
    if @sale_setting.blank?
      @sale_setting = SaleSetting.create(business_id: @business.id)
    end
    @flag = false
    if params[:to] == 'uncheck'
      @flag = false
    else
      @flag = true
    end
    if params[:what] == 'shipping_cost'
      @sale_setting.shipping_cost = @flag
    end
    if params[:what] == 'vat'
      @sale_setting.vat = @flag
    end
    if params[:what] == 'force_signin'
      @sale_setting.force_signin = @flag
    end
    @sale_setting.save
  end
end
