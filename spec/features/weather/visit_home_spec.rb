require 'rails_helper'

RSpec.feature "Widget management", :type => :feature do
  describe 'weather by city' do
    it 'shows search form on page load' do
      visit root_url
      expect(page).to have_text("Weather by City")
      expect(page).to have_text("Type city name in the search box")
    end

    before(:each) do
      visit root_url
    end

    context 'with a valid city name' do

      it 'returns results from default country' do
        response_body = "{\"coord\":{\"lon\":-80.19,\"lat\":25.77},\"weather\":[{\"id\":803,\"main\":\"Clouds\",\"description\":\"broken clouds\",\"icon\":\"04n\"}],\"base\":\"stations\",\"main\":{\"temp\":72.28,\"pressure\":1021,\"humidity\":83,\"temp_min\":69.8,\"temp_max\":73.4},\"visibility\":16093,\"wind\":{\"speed\":9.17,\"deg\":110},\"clouds\":{\"all\":75},\"dt\":1516588200,\"sys\":{\"type\":1,\"id\":691,\"message\":0.0048,\"country\":\"US\",\"sunrise\":1516622877,\"sunset\":1516661827},\"id\":4164138,\"name\":\"Miami\",\"cod\":200}"
        stub_request(:get, "#{FIND_BY_CITY_NAME}miami,US")
          .to_return(status: 200, body: response_body, headers: {})

        fill_in "City", with: "miami"
        click_button "Submit"

        expect(page).to have_text("Weather by City")
        expect(page).to have_text("Miami, United States")
        expect(page.find('img')['src']).to have_content('04n.png')
        expect(page).to have_text("broken clouds 72°F")
        expect(page).to have_text("Low 70°F, High 73°F")
        expect(page.find_field("city").value).to be_nil
      end

    end

    context 'with both valid city and country' do

      it 'returns results from selected country' do
        response_body = "{\"coord\":{\"lon\":12.48,\"lat\":41.89},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"base\":\"stations\",\"main\":{\"temp\":45.21,\"pressure\":1013,\"humidity\":70,\"temp_min\":44.6,\"temp_max\":46.4},\"visibility\":10000,\"wind\":{\"speed\":4.7,\"deg\":40},\"clouds\":{\"all\":0},\"dt\":1516586100,\"sys\":{\"type\":1,\"id\":5848,\"message\":0.0037,\"country\":\"IT\",\"sunrise\":1516602679,\"sunset\":1516637544},\"id\":6539761,\"name\":\"Rome\",\"cod\":200}"
        stub_request(:get, "#{FIND_BY_CITY_NAME}rome,IT")
          .to_return(status: 200, body: response_body, headers: {})

        fill_in "City", with: "rome"
        select "Italy", from: "country"
        click_button "Submit"

        expect(page).to have_text("Weather by City")
        expect(page).to have_text("Rome, Italy")
        expect(page.find('img')['src']).to have_content('01n.png')
        expect(page).to have_text("clear sky 45°F")
        expect(page).to have_text("Low 45°F, High 46°F")
        expect(page.find_field("city").value).to be_nil
      end
    end

    context 'submit search with invalid city name' do

      it 'returns City not found' do
        response_body = "{\"cod\":\"404\",\"message\":\"city not found\"}"
        stub_request(:get, "#{FIND_BY_CITY_NAME}test,US")
          .to_return(status: 200, body: response_body, headers: {})

        fill_in "City", with: "test"
        click_button "Submit"

        expect(page).to have_text("Weather by City")
        expect(page).to have_text("City not found")
        expect(page.find_field("city").value).to eq('test')
      end
    end

  end
end
