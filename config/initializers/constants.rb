COUNTRIES = YAML.load_file(File.join(Rails.root, 'config', 'countries.yml'))
APP_ID = 'xxxxxxxxxx'
WEATHER_BASE_URL = "http://api.openweathermap.org/data/2.5/weather?appid=#{APP_ID}&units=imperial&"
FIND_BY_CITY_NAME = "#{WEATHER_BASE_URL}q="
