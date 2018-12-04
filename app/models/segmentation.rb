class Segmentation < ActiveRecord::Base
  belongs_to :segment
  belongs_to :product
end
