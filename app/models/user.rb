class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :attachment, allow_destroy: true
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :attachment_attributes
  # attr_accessible :title, :body
  validates_presence_of :first_name

  def fetch_profile_picture
    self.attachment.present? ? self.attachment : self.build_attachment
  end

  def profile_picture_url
    self.attachment.present? ? self.attachment.photo.url : ""
  end
end
