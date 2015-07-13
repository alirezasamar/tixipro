class StoreController < ApplicationController
  def index
    if params[:genre].blank? && params[:venue].blank?
      @events = Event.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    elsif params[:genre] == 'All'
      @events = Event.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    elsif params[:venue].present? && params[:genre].present?
      @events = Event.order('created_at DESC').where(venue: params[:venue]).where(genre: params[:genre]).paginate(:page => params[:page], :per_page => 10)
    elsif params[:genre].present? && params[:venue].blank?
      @events = Event.order('created_at DESC').where(genre: params[:genre]).paginate(:page => params[:page], :per_page => 10)
    elsif params[:genre].blank? && params[:venue].present?
      @events = Event.order('created_at DESC').where(venue: params[:venue]).paginate(:page => params[:page], :per_page => 10)
    elsif params[:genre] == 'All'
      @events = Event.order('created_at DESC').where(venue: params[:venue]).paginate(:page => params[:page], :per_page => 10)
    else
      @events = Event.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    end
  end

  def faq
  end
end
