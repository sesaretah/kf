class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  validates_format_of :mobile, :with => /[0][9][1][0-9]{8,8}/i, :on => :create
  validates :username, uniqueness: true
  has_many :businesses
  has_one :profile
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
