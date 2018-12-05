class ApiController < ApplicationController
  before_filter :authenticate_user!, :except => [:segments, :products]
  before_action :load_business, only: [:segments,:products]
  def segments
    @data = []
    for segment in @business.segments.order('level desc, updated_at asc')
      @products = []
      if segment.view_in_homepage
        for product in segment.produkts
          @products << {'id' => product.id, 'name' => product.title, 'price' => product.price, 'currency' => rcurrencies(product.currency), 'picture' => request.base_url + product.image('medium')}
        end
        @data << {'label' =>  segment.title,  'icon' => 'stopwatch', 'products' => @products}
      end
    end
    render :json => @data.to_json, :callback => params['callback']
  end
  def products
    @product = @business.products.find(params[:id])
    @result = { 'productImageUrl' => request.base_url + @product.image('large'), 'productName' => @product.title, 'description' => @product.description, 'price' => @product.price, 'currency' => rcurrencies(@product.currency), 'category' => @product.category, 'subcategory' => @product.subcategory, 'subsubcategory' => @product.subsubcategory, 'tags': []}
    render :json => @result.to_json, :callback => params['callback']
  end
end
