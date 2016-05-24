class Post < ActiveRecord::Base
  RULES = { /-/ => '—', /"(?=\b)/ => '«', /(?=\b)"/ => '»' }

  validates :title, :content, presence: true
  validates :title, length: { minimum: 5 }

  default_scope -> { order(created_at: :desc) }
  
  before_save :typographize

  def typographize
    self.content = typograph(self.content) if self.content_changed?
  end

  def typograph(string)
    RULES.each { |rule, value| string.gsub!(rule, value) }
    string
  end
end
