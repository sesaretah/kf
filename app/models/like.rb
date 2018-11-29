class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, :polymorphic => true
  belongs_to :product, :class_name => "Product", :foreign_key => "likeable_id"
end
