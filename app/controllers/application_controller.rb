class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  helper_method :current_user, :render_asset, :render_colors_json

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def render_404
    render template: 'pages/404', status: 404
  end

  def render_asset(asset)
    f = File.open(Rails.root.join('app', 'assets', 'stylesheets', 'themes', 'custom.css'))
    str = f.read
    f.close
    str
  end

  def render_colors_json
    data = {}
    color_configs.each { |config| data[config.name] = config.value }
    data.to_json.html_safe
  end

  def color_configs
    configs = []
    theme_colors.each do |name|
      configs << SysConfig.find_config(name, nil)
    end

    configs
  end

  def theme_colors
    DefaultSetting.keys.select { |item| item.end_with?('_color') }
  end

  protected
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_admin
    if current_user.blank?
      redirect_to login_path
      false
    else
      true
    end
  end
end
