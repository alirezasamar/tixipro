class Event < ActiveRecord::Base
  include Bootsy::Container
  
  belongs_to :user
  has_many :tickets
  belongs_to :hall

  has_attached_file :cover_image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :cover_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  validates_presence_of :name, :venue, :description, :genre, :start, :end

  GENRES = %w(Dance Traditional Music Comedy Literature)

  # default_scope { where(active: true) }
end
