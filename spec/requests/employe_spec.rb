require 'rails_helper'

RSpec.describe "Employees", type: :request do
  describe  "GET /employee" do
    before { get '/employee' }

    it "Should return OK" do
      payload = JSON.parse(response.body)
      expect(payload['data']).to be_empty
      expect(payload['error']).to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe "With data in the DB" do

    let!(:employees) { create_list(:employee, 10) }
    before { get '/employee' }

    it "should return all the active employee" do
      payload = JSON.parse(response.body)
      expect(payload['data'].size).to eq(employees.size)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /employee/{id}" do
    let!(:employee) { create(:employee) }

    it "should return a employee" do
      get "/employee/#{employee.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(employee.id)
      expect(response).to have_http_status(200)
    end
  end

end