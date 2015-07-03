class User < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :tickets
  has_many :payments
  belongs_to :role
  has_many :authentications, dependent: :delete_all, autosave: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_presence_of :name
  before_save :assign_role

  def assign_role
    self.role = Role.find_by name: "Regular" if self.role.nil?
  end

  def admin?
    self.role.name == "Admin"
  end

  def curator?
    self.role.name == "Curator"
  end

  def regular?
    self.role.name == "Regular"
  end

  def apply_omniauth(omniauth)
    # self.username = omniauth['info']['nickname'] if username.blank?
    self.email = omniauth['info']['email'] if email.blank?

    authentications.build(:provider => omniauth['provider'],
                        :uid => omniauth['uid'],
                        :token => omniauth['credentials'].token,
                        :token_secret => omniauth['credentials'].secret)
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end
