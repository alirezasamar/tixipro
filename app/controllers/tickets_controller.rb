class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :set_event, except: [:my_tickets, :assign_tickets, :subcurator_tickets, :tickets_customization, :ticket_update_name, :print_tickets]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.where(event_id: @event)
    @line_item = current_cart.line_items.new
    @uploads = Upload.where(event_id: @event)
  end

  def print_tickets
    @ticket_id = params[:ticket_id]

    if current_user.curator? || current_user.admin? || current_user.subcurator?
      @my_tickets = LineItem.where(user_id: current_user.id).where(ticket_id: @ticket_id)
    else
      @my_tickets = LineItem.joins(:payment).where(payments: { user_id: current_user })
    end

    @ticket_type = Ticket.find_by(id: @ticket_id).ticket_type

     respond_to do |format|
       format.html
       format.pdf do
         pdf = PrintTicket.new(@my_tickets)
         send_data pdf.render, filename: "ticket_#{@ticket_type}",
                               type: "application/pdf",
                               disposition: "inline"
       end
     end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    # @my_tickets = LineItem.find_by user_id: current_user.id
    # @event = @my_tickets

  end

  def my_tickets
    if current_user.curator? || current_user.admin? || current_user.subcurator?
      @my_tickets = LineItem.where user_id: current_user
      @mts = @my_tickets.uniq.pluck(:ticket_id)
    else
      @my_tickets = LineItem.joins(:payment).where(payments: { user_id: current_user })
    end
  end

  def assign_tickets
    @curator = User.where(role: 2)
    @subcurator = User.where(role: 4)
    @my_tickets = LineItem.where(user_id: current_user.id).where(ticket_id: params[:ticket_id]).where(name: [nil, ''])
  end

  def subcurator_tickets
    LineItem.where(id: params[:mt_id]).update_all(user_id: params[:Subcurator])
    redirect_to my_tickets_path, notice: 'Ticket was successfully assigned to subcurator'
  end

  def tickets_customization
    @my_tickets = LineItem.where(user_id: current_user.id).where(ticket_id: params[:ticket_id])
  end

  def ticket_update_name
    name = params[:name]
    ids = params[:mt_id]
    map = Hash[ids.zip(name)]

    map.each {|k,v| LineItem.update(k, name: v)}
    redirect_to :back, notice: 'Name was added successfully'
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    if params[:ticket][:max_seat_no].to_i != 0
      quantity = (params[:ticket][:max_seat_no].to_i - params[:ticket][:min_seat_no].to_i) + 1
      @ticket.update_attributes quantity: quantity
    end

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to event_tickets_path(@event), notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to event_tickets_path(@event), notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to event_tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:ticket_type, :price, :quantity, :event_id, :max_seat_no, :min_seat_no, :name)
    end
end
