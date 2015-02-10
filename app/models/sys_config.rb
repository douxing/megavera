require 'digest/sha1'

class SysConfig < ActiveRecord::Base
  validates :name, presence: true
  validates :value, presence: true
end
