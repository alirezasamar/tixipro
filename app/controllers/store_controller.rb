class StoreController < ApplicationController
  def index
    @events = Event.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
  end

  def faq
  end
end
