class StoreController < ApplicationController
  def index
    @events = Event.all
  end

  def faq
  end
end
