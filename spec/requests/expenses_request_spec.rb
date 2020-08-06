require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  describe  "GET /expenses" do
    before { get '/expenses' }

    it "Should return OK" do
      payload = JSON.parse(response.body)
      expect(payload['body']).to be_empty
      expect(payload['errors']).to be_nil
      expect(response).to have_http_status(:ok)
    end
  end

  describe "With data in the DB" do
    let!(:expenses) { create_list(:expense, 10) }
    before { get '/expenses' }

    it "should return all expenses" do
      payload = JSON.parse(response.body)
      expect(payload['body'].size).to eq(expenses.size)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /expenses/{id}" do
    let!(:expense) { create(:expense) }

    it "should return a employee" do
      get "/expenses/#{expense.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['body']['id']).to eq(expense.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe  "POST /expenses" do

    it "Should create a expense" do
      req_payload = {
          expense: {
              release_date: Date.new(),
              category: "otros",
              cost: 105.5,
              currency_type: "soles",
              description: Faker::Lorem.paragraph
          }}
      # POST http
      post "/expenses", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload["body"]).to_not be_nil
      expect(payload["body"]["id"]).to_not be_nil
      expect(response).to have_http_status(:created)
    end

    it "Should not create expenses with invalid params" do
      req_payload = {
          expense: {
              release_date: Date.new(),
              category: "otros",
              currency_type: "pesos",
              description: Faker::Lorem.paragraph
          }}
      # POST http
      post "/expenses", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload["body"]).to be_nil
      expect(payload["errors"]).not_to be_nil
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
