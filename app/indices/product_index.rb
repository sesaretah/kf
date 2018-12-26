ThinkingSphinx::Index.define :product, :with => :real_time do
  indexes title
  indexes description

  has business_id,  :type => :integer
end
