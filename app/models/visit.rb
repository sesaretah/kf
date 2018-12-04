class Visit < ActiveRecord::Base
  belongs_to :visitable, :polymorphic => true
  belongs_to :product, :class_name => "Product", :foreign_key => "visitable_id"
end
