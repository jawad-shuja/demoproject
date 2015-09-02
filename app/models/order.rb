class Order < ActiveRecord::Base
  attr_accessible :subtotal, :total, :discount, :shipping_address

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  belongs_to :user

  validates :subtotal, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_address, presence: true

  def self.process_payment(cookies, user, params, credentials)
    amount = cookies[:total] || 0

    transaction = AuthorizeNet::AIM::Transaction.new(credentials['login'], credentials['key'], gateway: :sandbox)
    credit_card = AuthorizeNet::CreditCard.new(params[:card_num], params[:expiry_month] + params[:expiry_year])
    transaction.set_customer(AuthorizeNet::Customer.new(email: user.email))
    transaction.set_address(AuthorizeNet::Address.new(first_name: user.first_name, last_name: user.last_name))
    transaction.set_shipping_address(AuthorizeNet::ShippingAddress.new(street_address: params[:shipping_address]))
    transaction.purchase(amount.to_s, credit_card)
  end

  def created_date
    self.created_at.to_formatted_s(:long)
  end
end
