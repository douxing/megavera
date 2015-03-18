require 'digest/sha1'

class SysConfig < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :value, presence: true, allow_blank: true
  validate :color_value

  def self.find_config(name, locale)
    config = SysConfig.where(name: build_name(name, locale)).first
    unless config
      # get default setting
      begin
        value = DefaultSetting.send(build_name(name, locale))
        config = SysConfig.new
        config.name = build_name(name, locale)
        config.value = value
        config
      rescue Settingslogic::MissingSetting
        nil
      end
    end

    config
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

  def self.get_value(name, locale=nil)
    config = SysConfig.find_config(name, locale)
    config.nil? ? nil : config.value
  end

  def self.set_value(name, value, locale=nil)
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

  def color_value
    if self.name && self.name.end_with?("_color")
      errors.add(:value, "must be a valid CSS hex color code") unless self.value =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i
    end
  end
end
