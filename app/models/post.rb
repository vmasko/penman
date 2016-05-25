class Post < ActiveRecord::Base
  RULES = { /(?<=\s)-(?=\s)/ => '—', /("|')(?=\b)/ => '«', /(?=\b)("|')/ => '»', /\n/ => '<br>' }
  attr_accessor :remove_image, :publish

  has_and_belongs_to_many :categories

  default_scope -> { order(created_at: :desc) }
  scope :actual, -> { where('published_at <= ?', Time.now) }
  scope :actual_and_published, -> { actual.where(status: 'published') }

  has_attached_file :image, styles: { medium: "400x400>", thumb: "200x200>" }

  validates :title, :content, presence: true
  validates :title, length: { minimum: 5 }
  validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/png'] },
    size: { in: 0..1.megabytes }

  before_validation :typographize, :remove, :set_status, :schedule

  def schedule
    self.published_at = Time.now if self.published_at.nil?
  end

  def remove
    image.clear if remove_image == '1'
  end

  def set_status
    status = publish == '1' ? 'published' : 'drafted'
    self.status = status
  end

  def typographize
    self.content = typograph(self.content) if self.content_changed?
  end

  def typograph(string)
    RULES.each { |rule, value| string.gsub!(rule, value) }
    string
  end
end
