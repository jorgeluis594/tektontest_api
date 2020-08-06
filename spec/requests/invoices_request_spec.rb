require 'rails_helper'

RSpec.describe "Invoices", type: :request do
  describe  "GET /invoices" do
    before { get '/invoices' }

    it "Should return OK" do
      payload = JSON.parse(response.body)
      expect(payload['body']).to be_empty
      expect(payload['errors']).to be_nil
      expect(response).to have_http_status(:ok)
    end
  end

  describe "With data in the DB" do
    let!(:invoices) { create_list(:invoice, 10) }
    before { get '/invoices' }

    it "should return all expenses" do
      payload = JSON.parse(response.body)
      expect(payload['body'].size).to eq(invoices.size)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /invoices/{id}" do
    let!(:invoice) { create(:invoice) }

    it "should return a employee" do
      get "/invoices/#{invoice.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['body']['id']).to eq(invoice.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe  "POST /invoices" do
    let!(:product) {create(:product)}
    it "Should create a invoice" do
      req_payload = {
          invoice: {
              client: "Name",
              ruc: "12345",
              products: [
                  {id: product.id, quantity: 1}
              ]
          }}
      # POST http
      post "/invoices", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload["body"]).to_not be_nil
      expect(payload["body"]["id"]).to_not be_nil
      expect(response).to have_http_status(:created)
    end

    it "Should not create expenses with invalid params" do
      req_payload = {
          invoice: {
              client: "Name",
              ruc: "12345"
          }}
      # POST http
      post "/invoices", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload["body"]).to be_nil
      expect(payload["errors"]).not_to be_nil
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
