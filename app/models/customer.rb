class Customer < ApplicationRecord
  include CleanInput

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def self.pending_invoices(merchant_id)
    merchant_id = CleanInput.for_sql(merchant_id)
    find_by_sql("
      SELECT customers.* FROM customers INNER JOIN(
        SELECT invoices.id, invoices.customer_id 
        FROM invoices 
        INNER JOIN transactions 
        ON transactions.invoice_id = invoices.id 
        WHERE invoices.merchant_id = #{merchant_id}
        GROUP BY invoices.id 
        
        EXCEPT 

        SELECT invoices.id, invoices.customer_id 
        FROM invoices 
        INNER JOIN transactions 
        ON transactions.invoice_id = invoices.id 
        WHERE transactions.result = 'success') 

      AS invoices ON invoices.customer_id = customers.id
      ")
  end

  def favorite_merchant
      merchants
      .joins(invoices: :transactions)
      .merge(Transaction.successful)
      .group(:id)
      .order("count(invoices.id) DESC")
      .limit(1).first
  end
end
