class AdminController < ApplicationController
  before_filter :check_admin, except: [:new_session, :create_session]
  layout "admin", except: [:new_session, :create_session]

  def show
    @news = News.all_indexes.order("index_id DESC").limit(10)
    @news_count = News.all_indexes.pluck(:id).count
  end

  def new_session
    render layout: nil
  end

  def create_session
    ps = params.permit(:name, :password)
    user = User.authenticate(ps[:name], ps[:password])
    if user
      session[:user_id] = user.id
      redirect_to admin_path
    else
      render "new_session", layout: nil
    end
  end

  def destroy_session
    session[:user_id] = nil
    redirect_to login_path
  end

  def edit_social_recruitment
    get_config('social_recruitment', config_locale)
    render 'config', locals: { config: @config, form_path: social_recruitment_admin_path }
  end

  def update_social_recruitment
    get_config('social_recruitment', config_locale)
    @config.value = params.permit(:value)[:value]
    if @config.save
      redirect_to career_home_path
    else
      render 'config', locals: { config: @config, form_path: social_recruitment_admin_path }
    end
  end

  def edit_internship
    get_config('internship', config_locale)
    render 'config', locals: { config: @config, form_path: internship_admin_path }
  end

  def update_internship
    get_config('internship', config_locale)
    @config.value = params.permit(:value)[:value]
    if @config.save
      redirect_to career_home_path
    else
      render 'config', locals: { config: @config, form_path: internship_admin_path }
    end
  end

  def edit_theme
    @colors = []
    theme_colors.each do |name|
      @colors << SysConfig.find_config(name, nil)
    end
  end

  def update_theme
    values = params.permit(theme_colors)
    @colors = []
    @errors = []
    values.each do |name, value|
      config = SysConfig.find_config(name, nil)
      config.value = value
      @errors << config unless config.save
      @colors << config
    end

    render 'edit_theme'
  end

  def destroy_theme
    SysConfig.where(name: theme_colors).destroy_all

    @colors = []
    theme_colors.each do |name|
      @colors << SysConfig.find_config(name, nil)
    end
    render 'edit_theme'
  end

  protected
  def get_config(name, locale)
    @config = SysConfig.find_config(name, locale)
    unless @config
      @config = SysConfig.new
      @config.name = SysConfig.build_name(name, locale)
    end
  end

  def config_locale
    params.permit(:config_locale)[:config_locale] || 'en'
  end

  def theme_colors
    %w(background_color content_background_color content_text_color content_top_background_color content_top_text_color content_menu_background_color)
  end
end
