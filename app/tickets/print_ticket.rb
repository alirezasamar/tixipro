class PrintTicket < Prawn::Document

  def initialize(ticket)
    super(top_margin: 70)
    @ticket = ticket

    tickets
    # border
  end

  def tickets
    count = 0

    @ticket.each do |ticket|
      if count == 4 then
        start_new_page
      end

      text "UID: #{ticket.uid}"
      text "Event: #{ticket.ticket.event.name}"
      text "Ticket type: #{ticket.ticket.ticket_type}"
      text "Seat No: #{ticket.seat_no == 0 ? 'Free seating' : ticket.seat_no }"

      count += 1

      move_down 110
    end
  end

  # def border
  #   bounding_box([0,750], :width => 550, :height => 750) do
  #     stroke_color 'FFFF00'
  #     stroke_bounds
  #     text_box "Firma Conducente ________  Firma Cessionario _____",
  #           :size => 10, :at=> [50,700], :width => 550, :height => 750
  #   end
  # end



  # def item_header
  #   ["ID", "Item Name"]
  # end
  #
  # def item_rows
  #   @ticket.map { |item| [item.uid, item.ticket.ticket_type] }
  # end
  #
  # def item_table_data
  #   [item_header, *item_rows]
  # end
  #
  # def table
  #   table(item_table_data) do
  #
  #   end
  # end


  # def render_photo_table
  #   ps = [["UID", "ticket type", "Seat No"]] +
  #     @ticket.map do |item|
  #       [item.uid, item.ticket.ticket_type, item.seat_no]
  #     end
  #
  #   # ps = @ticket.map do |item|
  #   #   [[item.uid, item.ticket.ticket_type, item.seat_no]]
  #   #   start_new_page
  #   # end
  #   # ps.insert(0, ['UID', 'ticket type', 'Seat No'])
  #   table(ps) do |table|
  #     start_new_page
  #     table.header = true
  #   end
  # end

  # def line_items
  #   move_down 20
  #   table line_items_row do
  #     row(0).font_style = :bold
  #     columns(1..3).align = :right
  #     self.row_colors = ["DDDDDD", "FFFFFF"]
  #     self.header = true
  #   end
  #   # size = 100
  #   # bounding_box([0, cursor], :width => size, :height => size) do
  #   #  stroke_bounds
  #   #  line_items_row
  #   # end
  # end
  #
  # def line_items_row
  #   [["UID", "ticket type", "Seat No"]] +
  #   @ticket.map do |item|
  #     [item.uid, item.ticket.ticket_type, item.seat_no]
  #   end
  # end



end
