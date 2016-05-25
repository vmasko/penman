class Post < ActiveRecord::Base
  RULES = { /(?<=\s)-(?=\s)/ => '—', /"(?=\b)/ => '«', /(?=\b)"/ => '»', /\n/ => '<br>' }
  attr_accessor :remove_image, :publish

  has_attached_file :image, styles: { medium: "400x400>", thumb: "200x200>" }

  has_and_belongs_to_many :categories

  validates :title, :content, presence: true
  validates :title, length: { minimum: 5 }
  validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/png'] },
    size: { in: 0..1.megabytes }

  default_scope -> { order(created_at: :desc) }

  before_validation :typographize
  before_validation { image.clear if remove_image == '1' }
  before_validation { self.status = set_status }

  def set_status
    return 'scheduled' if self.schedule?
    return 'published' if publish == '1'
    'drafted'
  end

  def typographize
    self.content = typograph(self.content) if self.content_changed?
  end

  def typograph(string)
    RULES.each { |rule, value| string.gsub!(rule, value) }
    string
  end
end
