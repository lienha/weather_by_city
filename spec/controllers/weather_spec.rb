require 'rails_helper'

RSpec.describe WeatherController do

  context 'search has not started' do

    it 'assigns nil to @results' do
      results = nil
      get :index
      expect(response.status).to eq(200)
      expect(assigns(:results)).to eq(nil)
    end

  end

  context 'start a search' do

    it 'assigns @results' do
      response_body = "{\"cod\":\"404\",\"message\":\"city not found\"}"
      stub_request(:get, "#{FIND_BY_CITY_NAME}tdysu,US")
        .to_return(status: 200, body: response_body, headers: {})

      get :index, params: {city: "tdysu", country: "US"}
      expect(assigns(:results)).to eq(JSON.parse(response_body))
    end

  end

end
