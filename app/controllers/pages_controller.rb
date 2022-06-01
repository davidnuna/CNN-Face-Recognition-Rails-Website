class PagesController < ApplicationController

  def home
    @current_user = current_user&.decorate
  end
end
