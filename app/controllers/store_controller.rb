class StoreController < ApplicationController
  def index
    if params[:genre] == 'All' || params[:genre].nil?
      @events = Event.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    else
      @events = Event.order('created_at DESC').where(genre: params[:genre]).paginate(:page => params[:page], :per_page => 10)
    end
  end

  def faq
  end
end
