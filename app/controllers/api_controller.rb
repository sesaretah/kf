class ApiController < ApplicationController
  before_filter :authenticate_user!, :except => [:segments]
  before_action :load_business, only: [:segments]
  def segments
    @data = []
    for segment in @business.segments.order('level desc, updated_at asc')
      if segment.view_in_homepage.to_i != 0
        @products = []
        for product in segment.produkts
          @products << {'id' => product.id, 'name' => product.title, 'price' => product.price, 'currency' => rcurrencies(product.currency), 'picture' => request.base_url + product.image('medium')}
        end
      end
      @data << {'label' =>  segment.title,  'icon' => 'stopwatch', 'products' => @products}
    end
    render :json => @data.to_json, :callback => params['callback']
  end
end
