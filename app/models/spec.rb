class Spec < ActiveRecord::Base
  has_many :products, :through => :specifications
  has_many :specifications, dependent: :destroy
end
