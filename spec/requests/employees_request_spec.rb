require 'rails_helper'


RSpec.describe "Employees", type: :request do
  describe  "GET /employee" do
    before { get '/employees' }

    it "Should return OK" do
      payload = JSON.parse(response.body)
      expect(payload['body']).to be_empty
      expect(payload['errors']).to be_nil
      expect(response).to have_http_status(:ok)
    end
  end

  describe "With data in the DB" do

    let!(:employees) { create_list(:employee, 10) }
    before { get '/employees' }

    it "should return all the active employee" do
      payload = JSON.parse(response.body)
      expect(payload['body'].size).to eq(employees.size)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /employee/{id}" do
    let!(:employee) { create(:employee) }

    it "should return a employee" do
      get "/employees/#{employee.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['body']['id']).to eq(employee.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe  "POST /employees" do

    it "Should create a employee" do
      req_payload = {
          employee: {
          name: "name",
          dni: "12378",
          email: "correo@codeable.com",
          birth_date: Date.new,
          position: "manager"
      }}
      # POST http
      post "/employees", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload["body"]).to_not be_empty
      expect(payload["body"]["id"]).to_not be_nil
      expect(response).to have_http_status(:created)
    end

    it "Should not create employee with invalid params" do
      req_payload = {
          employee: {
              name: "name",
              email: "invalid_email.com",
              birth_date: Date.new,
              position: "manager"
          }}
      # POST http
      post "/employees", params: req_payload
      payload = JSON.parse(response.body)
      expect(payload["body"]).to be_nil
      expect(payload["errors"]).not_to be_nil
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end