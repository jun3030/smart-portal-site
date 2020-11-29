class Store < ApplicationRecord
  belongs_to :store_manager
  has_many :reviews, dependent: :destroy
  has_many :masseurs, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :store_images, dependent: :destroy
  accepts_nested_attributes_for :masseurs
  accepts_nested_attributes_for :store_images
  accepts_nested_attributes_for :plans
  validates :store_name, presence: true
  validates :adress, length: { minimum: 5 }, allow_blank: true
  validates :store_phonenumber, length: { minimum: 10 }, allow_blank: true
  validates :store_description, length: { minimum: 10 }, allow_blank: true
  enum calendar_status: { "released": 0, "private": 1 }, _prefix: true

  scope :categorized, -> (id) { includes(masseurs: :categories).where(categories: { id: id }) }
  scope :active, -> { includes(:store_manager).where.not(store_managers: {order_plan: nil}) }

  # 店舗口コミの総合平均点
  def avg_score
    unless self.reviews.empty?
      reviews.average(:rate).round(1).to_f
    else
      0.0
    end
  end

  # 店舗口コミの総合平均点
  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:rate).round(1).to_f*100/5
    else
      0.0
    end
  end

  ransacker :reviews_count do
    query = '(SELECT COUNT(reviews.store_id) FROM reviews where reviews.store_id = stores.id GROUP BY reviews.store_id)'
    Arel.sql(query)
  end

  ransacker :reviews_evaluation do
    query = '(SELECT AVG(reviews.rate) FROM reviews where reviews.store_id = stores.id GROUP BY reviews.store_id)'
    Arel.sql(query)
  end

  ransacker :plan_cheap do
    query = '(SELECT MIN(plans.plan_price) FROM plans where plans.store_id = stores.id GROUP BY plans.store_id)'
    Arel.sql(query)
  end
end
