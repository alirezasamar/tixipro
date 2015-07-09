class PrintTicket < Prawn::Document

  def initialize(ticket)
    super(top_margin: 70)
    @ticket = ticket
    line_items
  end

  def line_items
    move_down 20
    table line_items_row do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_items_row
    [["UID", "ticket type", "Seat No"]] +
    @ticket.map do |item|
      [item.uid, item.ticket.ticket_type, item.seat_no]
    end
  end

end
