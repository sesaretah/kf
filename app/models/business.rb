class Business < ActiveRecord::Base
  has_attached_file :logo, :styles => { :medium => "140x140>", :tiny => "20x20>" ,:thumb => "50x50>", :large => "600x600>"  }, :default_url => "/assets/noimage-35-:style.jpg"
  validates_attachment_content_type :logo, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  has_many :categories, :through => :classifications
  has_many :classifications, dependent: :destroy
  belongs_to :user
  has_many :products
  has_many :segments
  has_many :faqs
  belongs_to :theme
  has_many :pixels
  has_many :taxations
  has_one :sale_setting
  has_many :shipping_costs
  has_many :orders

  def image(style)
    @upload = Upload.where(uploadable_type: 'Business', uploadable_id: self.id, attachment_type: 'business_logo').last
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-35-#{style}.jpg", :digest => false)
    end
  end
end
