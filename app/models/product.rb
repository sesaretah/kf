class Product < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:product)
  has_many :specs, :through => :specifications
  has_many :specifications, dependent: :destroy

  has_many :carts, :through => :cart_items
  has_many :cart_items, dependent: :destroy

  has_many :categories, :through => :categorizations
  has_many :categorizations, dependent: :destroy
  belongs_to :business
  has_many :prominents

  has_many :segments, :through => :segmentations
  has_many :segmentations, dependent: :destroy

  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :visits, :as => :visitable, :dependent => :destroy

  def category
    @categorization = self.categorizations.where(level: 1).first
    if !@categorization.blank?
      return @categorization.category
    end
  end


  def subcategory
    @categorization = self.categorizations.where(level: 2).first
    if !@categorization.blank?
      return @categorization.category
    end
  end

  def subsubcategory
    @categorization = self.categorizations.where(level: 3).first
    if !@categorization.blank?
      return @categorization.category
    end
  end

  def image(style)
    @upload = Upload.where(uploadable_type: 'Product', uploadable_id: self.id, attachment_type: 'product_attachment').first
    if !@upload.blank?
      return @upload.attachment(style)
    else
      ActionController::Base.helpers.asset_path("noimage-35-#{style}.jpg", :digest => false)
    end
  end

  def images(style)
    @uploads = Upload.where(uploadable_type: 'Product', uploadable_id: self.id, attachment_type: 'product_attachment')
    if !@uploads.blank?
      @images = []
      for upload in @uploads
        @images << upload.attachment(style)
      end
      return @images
    else
      return [ActionController::Base.helpers.asset_path("noimage-35-#{style}.jpg", :digest => false)]
    end
  end
end
