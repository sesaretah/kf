class Upload < ActiveRecord::Base
  has_attached_file :attachment, :styles => { :medium => "300x300#", :tiny => "20x20>" ,:thumb => "50x50>", :large => "500x500>"  }, :default_url => "/assets/noimage-35-:style.jpg",  :processors => [:cropper]
  validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png"]
#  before_post_process :rename_avatar
#  before_post_process :resize_images
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :ratio, :caller
  after_update :reprocess_avatar, :if => :cropping?
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(attachment.path(style))
  end

#  def rename_avatar
#    if !self.attachment.blank?
#      extension = File.extname(attachment_file_name).downcase
#      self.attachment.instance_write :file_name, "#{Time.now.to_i.to_s}#{extension}"
#    end
#  end
#  def image?
#    attachment_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
#  end

  private

#  def resize_images
#    return false unless image?
#  end

  def reprocess_avatar
    attachment.assign(attachment)
    attachment.save
  end
end
