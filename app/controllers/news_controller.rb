class NewsController < ApplicationController
  layout "admin"
  before_filter :check_admin, except: [:show]

  def index
    @index_ids = News.all_indexes.pluck(:index_id).sort { |x, y| y <=> x }
    @index_ids = Kaminari.paginate_array(@index_ids).page(params[:page]).per(10)
    @news = News.where(index_id: @index_ids).group(:index_id)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    raise ActiveRecord::RecordNotFound if News.by_index_id(params[:id]).blank?
    @news = News.by_index_id(params[:id]).by_locale(params[:locale] || 'en').first
    @news = News.by_index_id(params[:id]).first unless @news
    raise ActiveRecord::RecordNotFound unless @news
    render layout: "application"
  end

  # GET /news/new
  def new
    news_locale = params[:news_locale]
    news_locale ||= 'en'
    @news = News.new
    @news.news_locale = news_locale
  end

  # GET /news/1/edit
  def edit
    news_locale = params[:news_locale] || 'en'
    @news = News.by_index_id(params[:id]).by_locale(news_locale).first
    unless @news
      @news = News.new
      @news.index_id = params[:id]
      @news.news_locale = news_locale
    end
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to news_index_path, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    @news = News.find(params[:id])
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to news_index_url, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    News.by_index_id(params[:id]).destroy_all
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :content, :news_locale, :index_id)
    end
end
