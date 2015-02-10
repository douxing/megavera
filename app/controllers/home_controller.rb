class HomeController < ApplicationController
  def contact
  end

  def career
  end

  def news
    @news = News.order("created_at DESC")
  end

  def specialities
  end

  def typical_solution
  end

  def about
  end
end
