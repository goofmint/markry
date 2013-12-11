class Tagging < ActiveRecord::Base
  belongs_to :summary
  belongs_to :tag
end
