class Faq < ActiveRecord::Base
  belongs_to :business
  before_create :determine_rank

  def determine_rank
    @faq = Faq.all.order('rank desc').first
    if !@faq.blank?
      self.rank = @faq.rank.to_i + 1
    else
      self.rank = 0
    end
  end
end
