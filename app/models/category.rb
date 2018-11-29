class Category < ActiveRecord::Base
  has_many :businesses, :through => :classifications
  has_many :classifications, dependent: :destroy

  has_many :products, :through => :categorizations
  has_many :categorizations, dependent: :destroy
end
