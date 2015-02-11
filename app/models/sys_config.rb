require 'digest/sha1'

class SysConfig < ActiveRecord::Base
  validates :name, presence: true
  validates :value, presence: true, allow_blank: true

  def self.find_config(name, locale)
    SysConfig.where(name: build_name(name, locale)).first
  end

  def self.build_name(name, locale)
    return "#{name}_*_#{locale}" if locale
    name.to_s
  end

  def self.get_locales(name)
    base_name = name.split("_*_").first
    names = SysConfig.where("name like '#{base_name}_*_%'").pluck(:name)
    names.collect { |a| a.split('_*_').last }
  end

  def self.get_value(name, locale)
    config = SysConfig.find_config(name, locale)
    config.nil? ? nil : config.value
  end

  def self.set_value(name, locale, value)
    config = SysConfig.find_config(name, locale)
    if config.nil?
      config = SysConfig.new
      config.name = name
    end

    config.value = value
    config.save!
    config.value
  end

  def locale
    tmps = self.name.split('_*_')
    return nil if tmps.count == 1
    tmps.last
  end

  def name_str
    tmps = self.name.split('_*_')
    tmps.join(' ')
  end
end
