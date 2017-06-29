require 'rails_helper'

describe 'Transactions API' do
  context "GET /api/v1/transactions" do
    it 'sends all transactions' do
      create_list(:transaction, 5)

      get '/api/v1/transactions'

      expect(response).to be_success
      
      transactions =  JSON.parse(response.body)
      transaction = transactions.first

      expect(transactions.count).to eq(5)
      expect(transaction).to have_key("invoice_id")
      expect(transaction["invoice_id"]).to be_a Integer
      expect(transaction).to have_key("credit_card_number")
      expect(transaction["credit_card_number"]).to be_a String
      expect(transaction).to have_key("result")
      expect(transaction["result"]).to be_a String
    end
  end

  context 'GET /api/v1/transactions/:id' do
    it 'sends one transaction' do
      transaction = create(:transaction)

      get "/api/v1/transactions/#{transaction.id}"

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["result"]).to be_a String
    end
  end

  context 'GET /api/v1/merchants/find_all?params' do
    date = "2017-06-26 22:58:34 UTC"
    let(:transaction) { create(:transaction, created_at: date, updated_at: date) }

    it 'sends all transactions requested by id' do
      id_params = { id: transaction.id }

      get '/api/v1/transactions/find_all', params: id_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)
      expect(raw_transaction.count).to eq(1)

      expect(raw_transaction.first["id"]).to eq(transaction.id)
    end

    it 'sends all transactions requested by invoice_id' do
      invoice_id_params = { invoice_id: transaction.invoice_id }

      get '/api/v1/transactions/find_all', params: invoice_id_params
      
      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)
      expect(raw_transaction.count).to eq(1)

      expect(raw_transaction.first["id"]).to eq(transaction.id)
    end

    it 'sends all transactions requested by credit_card_number' do
      credit_card_number_params = { credit_card_number: transaction.credit_card_number }

      get '/api/v1/transactions/find_all', params: credit_card_number_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)
      expect(raw_transaction.count).to eq(1)

      expect(raw_transaction.first["id"]).to eq(transaction.id)
    end

    it 'sends all transactions requested by result case matching' do
      result_params = { result: transaction.result }

      get '/api/v1/transactions/find_all', params: result_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)
      expect(raw_transaction.count).to eq(1)

      expect(raw_transaction.first["id"]).to eq(transaction.id)
    end

    it 'sends all transactions requested by result case not matching' do
      result_params = { result: transaction.result.upcase }

      get '/api/v1/transactions/find_all', params: result_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)
      expect(raw_transaction.count).to eq(1)

      expect(raw_transaction.first["id"]).to eq(transaction.id)
    end

    it 'sends all transactions requested by created_at' do
      created_at_params = { created_at: transaction.created_at }

      get '/api/v1/transactions/find_all', params: created_at_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)
      expect(raw_transaction.count).to eq(1)

      expect(raw_transaction.first["id"]).to eq(transaction.id)
    end

    it 'sends all transactions requested by updated_at' do
      updated_at_params = { updated_at: transaction.updated_at }

      get '/api/v1/transactions/find_all', params: updated_at_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)
      expect(raw_transaction.count).to eq(1)

      expect(raw_transaction.first["id"]).to eq(transaction.id)
    end
  end

  context 'GET /api/v1/merchants/find?params' do
    date = "2017-06-26 22:58:34 UTC"
    let(:transaction) { create(:transaction, created_at: date, updated_at: date) }

    it 'sends first transaction requested by id' do
      id_params = { id: transaction.id }

      get '/api/v1/transactions/find', params: id_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction.id)
    end

    it 'sends first transaction requested by invoice_id' do
      invoice_id_params = { invoice_id: transaction.invoice_id }

      get '/api/v1/transactions/find', params: invoice_id_params
      
      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction.id)
    end

    it 'sends first transaction requested by credit_card_number' do
      credit_card_number_params = { credit_card_number: transaction.credit_card_number }

      get '/api/v1/transactions/find', params: credit_card_number_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction.id)
    end

    it 'sends first transaction requested by result case matching' do
      result_params = { result: transaction.result }

      get '/api/v1/transactions/find', params: result_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction.id)
    end

    it 'sends first transaction requested by result case not matching' do
      result_params = { result: transaction.result.upcase }

      get '/api/v1/transactions/find', params: result_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction.id)
    end

    it 'sends first transaction requested by created_at' do
      created_at_params = { created_at: transaction.created_at }

      get '/api/v1/transactions/find', params: created_at_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction.id)
    end

    it 'sends first transaction requested by updated_at' do
      updated_at_params = { updated_at: transaction.updated_at }

      get '/api/v1/transactions/find', params: updated_at_params

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction.id)
    end
  end
end
