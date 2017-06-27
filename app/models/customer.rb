class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices


  def self.pending_invoices(merchant_id)
    find_by_sql("
      SELECT customers.id, customers.first_name, customers.last_name FROM customers INNER JOIN(
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

  def self.favorite_customer(merchant_id)
    joins('JOIN invoices ON invoices.customer_id = customers.id')
    .joins('JOIN transactions ON invoices.id = transactions.invoice_id')
    .where('invoices.merchant_id = ? AND transactions.result = ?', merchant_id, 'success')
    .group('customers.id')
    .order('count(customers.id) desc')
    .limit(1)
    .first
  end
end
