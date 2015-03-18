class DefaultSetting < Settingslogic
  source "#{Rails.root}/config/default_setting.yml"
  namespace Rails.env
end
