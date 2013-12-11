class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :summaries, :through => :taggings
end
