require 'rails_helper'

RSpec.describe WeatherHelper, :type => :helper do
  before(:each) do
    let(:results) do
      {"coord"=>{"lon"=>-117.83, "lat"=>33.69}, "weather"=>[{"id"=>803, "main"=>"Clouds", "description"=>"broken clouds", "icon"=>"04d"}], "base"=>"stations", "main"=>{"temp"=>61.16, "pressure"=>1025, "humidity"=>42, "temp_min"=>57.2, "temp_max"=>64.4}, "visibility"=>16093, "wind"=>{"speed"=>6.93, "deg"=>220}, "clouds"=>{"all"=>75}, "dt"=>1516568280, "sys"=>{"type"=>1, "id"=>485, "message"=>0.0056, "country"=>"US", "sunrise"=>1516546410, "sunset"=>1516583562}, "id"=>5359777, "name"=>"Irvine", "cod"=>200
      }
    end
  end

  it 'return response status' do

  end

  it 'returns city name' do
    city_name = results['name']
    assign(:city, city_name)
    expect(helper.city).to eql("Irvine")
  end

  it 'returns full country name' do
    # helper.country.should eql("United States")
  end

  it 'returns weather condition description' do

  end

  it 'returns the round up temperature' do

  end

  it 'returns round up low temperature' do

  end

  it 'returns round up high temperature' do

  end

  it 'returns weather condition icon' do

  end

  it 'returns last city name if results not found' do

  end

  it 'returns nil if city found' do

  end
end