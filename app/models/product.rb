class Product < ActiveRecord::Base
  has_many :specs, :through => :specifications
  has_many :specifications, dependent: :destroy

  has_many :categories, :through => :categorizations
  has_many :categorizations, dependent: :destroy
  belongs_to :business
  has_many :prominents

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
