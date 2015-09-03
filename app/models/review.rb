class Review < ActiveRecord::Base
  PER_PAGE = 5
  belongs_to :product
  belongs_to :user
  attr_accessible :body

  validates :body, presence: true, length: { maximum: 500 }
  scope :ordered, -> { order('created_at DESC') }

  def author
    self.user.full_name
  end

  def created_date
    self.created_at.to_formatted_s(:long)
  end
end
