require 'pry'
require 'csv'

desc 'Imports database information from CSV files'
task :import => [:environment] do

  CSV.foreach("#{Rails.root}/db/csv/customers.csv", headers: true, header_converters: :symbol) do |row|
    Customer.create(row.to_h)
  end

  CSV.foreach("#{Rails.root}/db/csv/merchants.csv", headers: true, header_converters: :symbol) do |row|
    Merchant.create(row.to_h)
  end

  CSV.foreach("#{Rails.root}/db/csv/invoices.csv", headers: true, header_converters: :symbol) do |row|
    Invoice.create(row.to_h)
  end

  CSV.foreach("#{Rails.root}/db/csv/transactions.csv", headers: true, header_converters: :symbol) do |row|
    Transaction.create(row.to_h.delete_if { |key, value| key == :credit_card_expiration_date })
  end
  CSV.foreach("#{Rails.root}/db/csv/items.csv", headers: true, header_converters: :symbol) do |row|
    Item.create(row.to_h)
  end

  CSV.foreach("#{Rails.root}/db/csv/invoice_items.csv", headers: true, header_converters: :symbol) do |row|
    InvoiceItem.create(row.to_h)
  end
end
