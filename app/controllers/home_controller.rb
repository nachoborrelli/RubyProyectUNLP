class HomeController < ApplicationController

  def index
    if current_user
      @books = current_user.books
    end
  end

end
