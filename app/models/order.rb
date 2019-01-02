class Order < ActiveRecord::Base
  
  has_many :order_items
  belongs_to :order_status
  belongs_to :user
  belongs_to :business
  belongs_to :province
  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.hex(4)
  end

end
