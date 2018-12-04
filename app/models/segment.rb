class Segment < ActiveRecord::Base
  has_many :products, :through => :segmentations
  has_many :segmentations, dependent: :destroy
  belongs_to :business
  before_create :determine_level

  def produkts
    if self.ext_code.blank?
      return self.products
    else
      return Product.find_by_sql(self.ext_code)
    end
  end

  def determine_level
    @segment = Segment.all.order('level desc').first
    if !@segment.blank?
      self.level = @segment.level.to_i + 1
    end
  end

  def level_down
    self.level = self.level - 1
    self.save
  end

  def level_up
    self.level = self.level + 1
    self.save
  end
end
