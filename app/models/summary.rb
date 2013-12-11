class Summary < ActiveRecord::Base
  belongs_to :user
  has_many :taggings
  has_many :tags, :through => :taggings
  
  before_create :generate_temporary_code
  
  def title
    return "" if body.blank?
    body.split(/\r\n|\r|\n/)[0].gsub(/^# /, "")
  end

  def body_view
    body.to_s.split(/\r\n|\r|\n/)[2..-1].join("\n")
  end

  def generate_temporary_code
    self.temporary_code = Devise.friendly_token.first(20)
  end

  def title=(title)
    self.body = "# #{title}" if self.body.blank?
  end

  def string_tag
    self.tags.map(&:name).join(",")
  end

  def string_tag=(string_tag)
    string_tag.to_s.split(",").each do |name|
      self.tags << Tag.where(:name => name).first_or_create
    end
  end
end
