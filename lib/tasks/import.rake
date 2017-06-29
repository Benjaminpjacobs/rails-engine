require 'csv'

namespace :import do
  desc "Create all survey templates"

  task :regenerate do
    Rails.env = "development"
    Rake::Task["db:reset"].invoke
    Rails.env = "test"
    Rake::Task["db:reset"].invoke
  end

  task :all => [:import_customers, :import_merchants, :import_invoices, :import_transactions,:import_items, :import_invoice_items]
  
  task :import_customers => [:environment] do
    puts "importing customers..."
    CSV.foreach("#{Rails.root}/db/csv/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create(row.to_h)
    end
  end
  
  task :import_merchants => [:environment] do
    puts "importing merchants..."
    CSV.foreach("#{Rails.root}/db/csv/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create(row.to_h)
    end
  end
  
  task :import_invoices => [:environment] do
    puts "importing invoices..."
    CSV.foreach("#{Rails.root}/db/csv/invoices.csv", headers: true, header_converters: :symbol) do |row|
      Invoice.create(row.to_h)
    end
  end
  
  task :import_transactions => [:environment] do
    puts "importing transactions..."
    CSV.foreach("#{Rails.root}/db/csv/transactions.csv", headers: true, header_converters: :symbol) do |row|
      Transaction.create(row.to_h.delete_if { |key, value| key == :credit_card_expiration_date })
    end
  end
  
  task :import_items => [:environment] do
    puts "importing items..."
    CSV.foreach("#{Rails.root}/db/csv/items.csv", headers: true, header_converters: :symbol) do |row|
      Item.create(row.to_h)
    end
  end
  
  task :import_invoice_items => [:environment] do
    puts "importing invoice items..."
    CSV.foreach("#{Rails.root}/db/csv/invoice_items.csv", headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_h)
    end
  end
end
