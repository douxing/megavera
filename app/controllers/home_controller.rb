class HomeController < ApplicationController
  def contact
  end

  def career
  end

  def news
    @news = News.by_locale(params[:locale] || 'en').order("index_id DESC")
  end

  def specialities
  end

  def typical_solution
  end

  def about
  end
end
