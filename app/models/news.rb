class News < ActiveRecord::Base
  validates :title, presence: true, length: { in: 2..255 }
  validates :content, presence: true
  validates :index_id, presence: true, numericality: { only_integer: true }, if: Proc.new { |a| !a.index_id.nil? }
  validates :news_locale, presence: true, uniqueness: { scope: :index_id }

  scope :all_indexes, -> { group(:index_id) }
  scope :by_index_id, ->(index_id) { where(index_id: index_id) }
  scope :by_locale, ->(locale) { where(news_locale: locale) }

  before_create :calc_index_id

  private
  def calc_index_id
    if self.index_id.nil?
      config = SysConfig.where(name: :news_index_id).first
      if config.nil?
        config = SysConfig.new
        config.name = 'news_index_id'
        config.value = 1
        config.save!
      end

      config.lock!
      self.index_id = config.value.to_i
      config.value = (self.index_id + 1).to_s
      config.save!
    end
  end

  def all
    all_news = News.where(index_id: self.index_id)
  end

  def locales
    self.all.pluck(:news_locale)
  end
end
