class User < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :tickets
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  before_save :assign_role

  def assign_role
    self.role = Role.find_by name: "Regular" if self.role.nil?
  end

  def admin?
    self.role.name == "Admin"
  end

  def organizer?
    self.role.name == "Organizer"
  end

  def regular?
    self.role.name == "Regular"
  end

end
