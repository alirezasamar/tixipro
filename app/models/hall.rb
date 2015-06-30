class Hall < ActiveRecord::Base
  has_many :events

  has_attached_file :seat_view, styles: { small: "64x64", med: "100x100", large: "200x200" }

  validates_attachment :seat_view, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  validates_presence_of :name, :description

end
