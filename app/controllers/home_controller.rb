class HomeController < ApplicationController
  def contact
  end

  def career
  end

  def news
    @news = News.by_locale(params[:locale] || 'en')
    @index_ids = @news.all_indexes.pluck(:index_id).sort { |x, y| y <=> x }
    @index_ids = Kaminari.paginate_array(@index_ids).page(params[:page]).per(20)
    @news = @news.where(index_id: @index_ids).order("created_at DESC")
  end

  def specialities
  end

  def typical_solution
  end

  def about
  end
end
