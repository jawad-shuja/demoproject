class Product < ActiveRecord::Base
  PER_PAGE = 6
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products
  belongs_to :user
  accepts_nested_attributes_for :attachments, reject_if: proc { |attributes| attributes['photo'].blank? }, allow_destroy: true

  validates :title, presence: true, length: { maximum: 70 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }

  attr_accessible :body, :price, :title, :attachments_attributes
  scope :ordered, -> { order('created_at DESC') }

  def author
    self.user.full_name
  end

  def self.perform_search(options = {})
    options[:per_page] = PER_PAGE if options.present?
    self.search options[:search], options
  end

  define_index do
    indexes title
    indexes body
    set_property delta: true

    has :created_at
  end
end
