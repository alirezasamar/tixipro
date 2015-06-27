class Event < ActiveRecord::Base
  belongs_to :user
  has_many :tickets

  has_attached_file :cover_image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :cover_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  validates_presence_of :name, :venue, :description, :genre, :start, :end

  GENRES = %w(Dance Traditional Music Comedy Literature)
end
