class Product < ActiveRecord::Base
  has_many :specs, :through => :specifications
  has_many :specifications, dependent: :destroy

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
end
