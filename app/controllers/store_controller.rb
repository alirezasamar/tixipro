class StoreController < ApplicationController
  def index
    @events = Event.all
  end
end
