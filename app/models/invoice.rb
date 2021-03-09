class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def find_bulk_discounts
    invoice_items
    .joins(:bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity")
    .select("(invoice_items.quantity * invoice_items.unit_price)/bulk_discounts.percent AS discount, invoice_items.*, bulk_discounts.id AS discount_id")
    .order("bulk_discounts.percent desc")
    .uniq
  end

  def total_revenue_with_discount
    total_revenue -  find_bulk_discounts.sum(&:discount)
  end
end
