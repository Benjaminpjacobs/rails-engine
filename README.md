# Rails Engine

A sales data api built with Rails 5.1 and Ruby 2.4.1. This engine serves up record, relationship and business intelligence JSON for the included dataset.

* Clone down this repo
* Clone down [rails-engine spec harness](https://github.com/turingschool/rales_engine_spec_harness)
* Navigate into the railes-engine directory ```cd rails-engine```
* ```bundle```
* Create database ```rake db:setup```
* Import CSV files ```rake import:all```
* Run the server ```rails server```
* In another terminal window navigate into the rails-engine spec harness directory
* ```bundle``` 
* ```rake``` to run test suite.

Interact with this API at the [Swagger Application UI](https://sales-engine-api.herokuapp.com/apidocs/index.html) or on
[Swagger Hub](https://app.swaggerhub.com/apis/Benjaminpjacobs/sales-engine-api/1.0.0).

---
## Endpoints accessible with this API:


### Customers API
* GET /api/v1/customers
  * sends all customers
* GET /api/v1/customers/:id
  * sends one customer
* GET /api/v1/customers/find_all?params
  *  sends all customers requested by id
  *  sends all customers requested by first_name case matching
  *  sends all customers requested by first_name case not matching
  *  sends all customers requested by last_name case matching
  *  sends all customers requested by last_name case not matching
  *  sends all customers requested by created_at
  *  sends all customers requested by updated_at
* GET /api/v1/customers/find?params
  *  sends first customer requested by id
  *  sends first customer requested by first_name matching
  *  sends first customer requested by first_name not matching
  *  sends first customer requested by last_name case matching
  *  sends first customer requested by last_name not matching
  *  sends first customer requested by created_at
  *  sends first customer requested by updated_at
* GET /api/v1/customers/random
  * sends a random customer

### Customers Relationship Endpoints
* GET /api/v1/customers/:id/invoices
  * returns a collection of associated invoices
* GET /api/v1/customers/:id/transactions
  * returns a collection of associated transactions

### Customer Business Intelligence Endpoints
* GET /api/v1/customers/:id/favorite_merchant
  * returns a merchant where the customer has conducted the most successful transactions

### Invoices Relationship Endpoints
* GET /api/v1/invoices/:id/transactions
  * returns a collection of associated transactions
* GET /api/v1/invoices/:id/invoice_items
  * returns a collection of associated invoice items
* GET /api/v1/invoices/:id/items
  * returns a collection of associated items
* GET /api/v1/invoices/:id/customer
  * returns the associated customer
* GET /api/v1/invoices/:id/merchant
  * returns the associated merchant

### InvoiceItems Relationship Endpoints
* GET /api/v1/invoice_items/:id/invoice
  * sends the invoice for requested invoice_item
* GET /api/v1/invoice_items/:id/item
  * sends the item for requested invoice_item

### Invoice Items API
* GET /api/v1/invoice_items
  * sends a list of all invoice items
* GET /api/v1/invoice_items/:id
  * sends a single invoice item
* GET /api/v1/invoice_items/find?params
  *  sends first invoice_item based on item id
  *  send first invoice_item based on invoice id
  *  send first invoice_item based on unit price
  *  sends first invoice_item based on item quantity
  *  send first invoice_item based on created date
  *  sends first invoice_item based on updated date
* GET /api/v1/invoice_items/find_all?params
  *  sends all invoice_items based on item id
  *  send all invoice_items based on invoice id
  *  sends all invoice_items based on unit price
  *  sends all invoice_items based on created at date
  *  sends all invoice_items based on updated at date
* GET /api/v1/invoice_items/random
  * sends a random invoice_item

### Invoice API
* GET /api/v1/invoices
  * sends a list of invoices
* GET /api/v1/invoices/:id
  * sends a single invoice
* GET /api/v1/invoices/find?params
  * finds a single invoice based on customer id
  * finds a single invoice based on merchant id
  * finds a single invoice based on invoice status case matching
  * finds a single invoice based on invoice status case insensitive
  * finds a single invoice based on created at date
  * finds a single invoice based on updated at date
* GET /api/v1/invoices/find_all?params
  * finds all invoices based on customer id
  * finds all invoices based on merchant id
  * finds all invoices based on invoice status case matching
  * finds all invoices based on invoice status case insenstive
  * finds all invoices based on created at date
  * finds all invoices based on updated at date
* GET /api/v1/invoices/random
  * sends a random invoice

### Item Relationship Endpoints
* GET /api/v1/items/:id/invoice_items
  * sends all invoice_items associated with the requested item
* GET /api/v1/items/:id/merchant
  * sends the merchant associated with the requested item

### Items Business Intelligence API requests
* GET /api/v1/items/most_items?quantity=x
  * returns the top x item instances ranked by total number sold
* GET /api/v1/items/most_revenue?quantity=x
  * returns the top x items ranked by total revenue generated
* GET /api/v1/items/:id/best_day
  * returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

### Item API
* GET /api/v1/items
  * sends a list of all items
* GET /api/v1/items/:id
  * sends a single item
* GET /api/v1/items/find?params
  * finds an item based on name case matching
  * finds an item based on name case insensitive
  * finds an item based on descripion case matching
  * finds an item based on description case insensitive
  * finds an item based on unit prices
  * finds an item based on merchant id
  * finds an item based on created at date
  * finds an item based on updated at date
* GET /api/v1/items/find_all?params
  * finds all items based on item id
  * finds all items based on item name case matching
  * finds all items based on item name case insenstitive
  * finds all items based on item description case matching
  * finds all items based on description case insensitive
  * finds all items based on unit price
  * finds all items based on merchant id
  * finds all items based on created at date
  * finds all items baased on updated at date
* GET /api/v1/items/random
  * sends a random item

### Merchants Relationship Endpoints
* GET /api/v1/merchants/:id/items
  * returns a collection of items associated with that merchant
* GET /api/v1/merchants/:id/invoices
  * returns a collection of invoices associated with that merchant from their known orders

### Merchant Business Intelligence Endpoints
#### All Merchants
* GET /api/v1/merchants/most_revenue?quantity=x
  * returns the top x merchants ranked by total revenue
* GET /api/v1/merchants/most_items?quantity=x
  * returns the top x merchants ranked by total number of items sold
* GET /api/v1/merchants/revenue?date=x
  * sends total merchant revenue on date
#### Single Merchant
* GET /api/v1/merchants/:id/revenue
  * returns the total revenue for that merchant across all transactions
* GET /api/v1/merchants/:id/revenue?date=x
  * returns the total revenue for that merchant for a specific invoice date x
* GET /api/v1/merchants/:id/favorite_customer
  * returns the customer who has conducted the most total number of successful transactions
* GET /api/v1/merchants/:id/customers_with_pending_invoices
  * returns a collection of customers which have pending (unpaid) invoices.

### Merchants API
* GET /api/v1/merchants
  * sends all merchants
* GET /api/v1/merchants/:id
  * sends one merchant
* GET /api/v1/merchants/find_all?params
  * sends all merchants requested by id
  * sends all merchants requested by name case matching
  * sends all merchants requested by name case not matching
  * sends all merchants requested by created_at
  * sends all merchants requested by updated_at
 * GET /api/v1/merchants/find?params
  * sends first merchant requested by id
  * sends first merchant requested by name
  * sends first merchant requested by name case not matching
  * sends first merchant requested by created_at
  * sends first merchant requested by updated_at
* GET /api/v1/merchants/random
  * sends a random merchant

### Transactions Relationship Endpoints
* GET /api/v1/transations/:id/invoice
  * sends associated invoice

### Transactions API
* GET /api/v1/transactions
  * sends all transactions
* GET /api/v1/transactions/:id
  * sends one transaction
* GET /api/v1/merchants/find_all?params
  * sends all transactions requested by id
  * sends all transactions requested by invoice_id
  * sends all transactions requested by credit_card_number
  * sends all transactions requested by result case matching
  * sends all transactions requested by result case not matching
  * sends all transactions requested by created_at
  * sends all transactions requested by updated_at
* GET /api/v1/merchants/find?params
  * sends first transaction requested by id
  * sends first transaction requested by invoice_id
  * sends first transaction requested by credit_card_number
  * sends first transaction requested by result case matching
  * sends first transaction requested by result case not matching
  * sends first transaction requested by created_at
  * sends first transaction requested by updated_at
* GET /api/v1/transactions/random
  * sends a random transaction
