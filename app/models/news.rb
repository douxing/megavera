class News < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
  validates :chinese_title, presence: true
  validates :chinese_content, presence: true

  mount_uploader :image, ImageUploader
end
