class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:segments, :products, :business, :upload_pict, :categories, :paginated_products]
  before_action :load_business, only: [:segments,:products, :business, :upload_pict, :categories, :paginated_products]
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
    @result = { 'productImageUrl' =>  @product.images('large').each{ |i| ["#{request.subdomain+i}"]}, 'productName' => @product.title, 'description' => @product.description, 'price' => @product.price, 'currency' => rcurrencies(@product.currency), 'category' => @product.category, 'subcategory' => @product.subcategory, 'subsubcategory' => @product.subsubcategory, 'tags': []}
    render :json => @result.to_json, :callback => params['callback']
  end

  def business
    @business = { 'logo' => request.base_url + @business.logo('large'), 'name' => @business.title, 'description' => @business.bio, 'instagramChannelAddr' => @business.instagram_page, 'telegramChannelAddr' => @business.telegram_channel, 'address' => @business.address, 'tel' => @business.tel, 'fax' => @business.fax, 'mobile' => @business.mobile, 'email' => @business.email, 'webpage' =>  @business.subdomain+'.'+'kaarafarin.ir'}
    render :json => @business.to_json, :callback => params['callback']
  end

  def new_user
    @user = User.new(username: request.subdomain+'_'+params['mobile'], mobile: params[:mobile], password: params['password'], password_confirmation: params['password_confirmation'])
    if @user.save
      @profile = Profile.create(user_id: @user.id, name: params[:name], surename: params[:surename])
      render :json => {token: JWTWrapper.encode({ user_id: @user.id })}.to_json, :callback => params['callback']
    else
      render :json => {error: @user.errors }.to_json , :callback => params['callback']
    end
  end

  def my_profile
    @profile = current_user.profile
    render :json => {name: @profile.name, surename: @profile.surename}.to_json, :callback => params['callback']
  end

  def upload_pict
    @upload = Upload.new
    @upload.uploadable_type = params[:uploadable_type]
    @upload.uploadable_id = params[:uploadable_id]
    @upload.attachment_type = params[:attachment_type]
    @upload.attachment = params[:file]
    if @upload.save
      render :json => {result: 'OK' }.to_json , :callback => params['callback']
    else
      render :json => {error: @user.errors }.to_json , :callback => params['callback']
    end
  end

  def paginated_products
    @products = @business.products.paginate(:page => params[:page], :per_page => params[:per_page])
    @total_pages = @products.total_pages
    @results = []
    for product in @products
      @results << {'id' => product.id, 'name' => product.title, 'picture' => request.base_url + product.image('large'), 'category' => {'id' => product.category.id}, 'subcategory' => {'id' => product.subcategory.id}}
    end
    if !@results.blank?
      render :json => {'products' => @results, 'page' => params[:page], 'per_page' => params[:per_page], 'total_pages' => @total_pages}.to_json , :callback => params['callback']
    else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end

  def categories
    @results = []
    @business.products.all.group_by(&:category).take(10).each do |g,p|
      @hash = {'id' =>  g.id, 'name' => g.title, 'subCategories' => []}
      @business.products.all.group_by(&:subcategory).each do |s, i|
        if s.parent_id == g.id
          @hash['subCategories'] << {'id' => s.id, 'name' => s.title}
        end
      end
      @results << @hash
    end
    if !@results.blank?
      render :json => @results.to_json , :callback => params['callback']
    else
      render :json => {result: 'NONE'}.to_json , :callback => params['callback']
    end
  end


end
