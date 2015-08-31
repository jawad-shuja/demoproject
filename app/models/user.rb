class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :attachment, as: :attachable, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders

  accepts_nested_attributes_for :attachment, allow_destroy: true

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :attachment_attributes

  validates_presence_of :first_name

  def new_order(cookies, params)
    total = cookies[:total] || 0
    cart = cookies[:cart] ? JSON.parse(cookies[:cart]) : []
    sub_total = cookies[:subtotal] || 0
    order = self.orders.new(subtotal: sub_total, total: total, discount: sub_total.to_f - total.to_f, shipping_address: params[:shipping_address])
    cart.each do |product|
      order.products << Product.find(product)
    end
    order
  end

  def fetch_profile_picture
    self.attachment.present? ? self.attachment : self.build_attachment
  end

  def profile_picture_url
    self.attachment.present? ? self.attachment.photo.url(:small) : ""
  end
end
