module WeatherHelper
  def status
    @trouble = false
    case @results['cod'].to_i
    when 200
      true
    when 404
      @results["message"]
    else
      @trouble = true
      "Weather is not available at this time, please try again later"
    end
  end

  def city
    @results["name"]
  end

  def description
    @results["weather"][0]['description']
  end

  def country
    COUNTRIES.key(@results['sys']['country']) || @results['sys']['country']
  end

  def weather_icon
    "http://openweathermap.org/img/w/#{@results["weather"][0]['icon']}.png"
  end

  def temperature
    @results['main']['temp'].round
  end

  def temp_min
    @results['main']['temp_min'].round
  end

  def temp_max
    @results['main']['temp_max'].round
  end

  def display_last_city_if_not_found
    @results && status == "city not found" ? params[:city] : nil
  end
end
