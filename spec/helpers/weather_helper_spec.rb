require 'rails_helper'

RSpec.describe WeatherHelper, :type => :helper do

  context 'Response status code is 200' do

    let(:results) do
      {"coord"=>{"lon"=>-117.83, "lat"=>33.69}, "weather"=>[{"id"=>803, "main"=>"Clouds", "description"=>"broken clouds", "icon"=>"04d"}], "base"=>"stations", "main"=>{"temp"=>61.16, "pressure"=>1025, "humidity"=>42, "temp_min"=>57.2, "temp_max"=>64.4}, "visibility"=>16093, "wind"=>{"speed"=>6.93, "deg"=>220}, "clouds"=>{"all"=>75}, "dt"=>1516568280, "sys"=>{"type"=>1, "id"=>485, "message"=>0.0056, "country"=>"US", "sunrise"=>1516546410, "sunset"=>1516583562}, "id"=>5359777, "name"=>"Irvine", "cod"=>200
      }
    end

    before(:each) do
      assign(:results, results)
    end

    it 'return response status' do
      expect(helper.status).to eql(true)
    end

    it 'returns city name' do
      expect(helper.city).to eql("Irvine")
    end

    it 'returns full country name' do
      expect(helper.country).to eql("United States")
    end

    it 'returns weather condition description' do
      expect(helper.description).to eql("broken clouds")
    end

    it 'returns the round up temperature' do
      expect(helper.temperature).to eql(61)
    end

    it 'returns round up low temperature' do
      expect(helper.temp_min).to eql(57)
    end

    it 'returns round up high temperature' do
      expect(helper.temp_max).to eql(64)
    end

    it 'returns weather condition icon' do
      expect(helper.weather_icon).to eql("http://openweathermap.org/img/w/04d.png")
    end

    it 'returns nil when results found' do
      expect(helper.display_last_city_if_not_found).to eql(nil)
    end
  end

  context 'response status code is 404' do

    let(:results) do
      {"cod"=>"404", "message"=>"city not found"}
    end

    before(:each) do
      params[:city] = "kdkdjdkjkd"
      assign(:results, results)
    end

    it 'returns status as city not found' do
      expect(helper.status).to eql("city not found")
    end

    it 'returns last city name if results not found' do
      expect(helper.display_last_city_if_not_found).to eql("kdkdjdkjkd")
    end
  end

  context 'response status other than 200 or 404' do

    it 'returns weather not available message' do
      results = {"cod"=>401, "message"=> "Invalid API key. Please see http://openweathermap.org/faq#error401 for more info."}
      assign(:results, results)
      expect(helper.status).to eql("Weather is not available at this time, please try again later")
    end
  end
end
