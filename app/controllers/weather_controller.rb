class WeatherController < ApplicationController
  def index
    if params[:city].nil? || params[:city].empty?
      @results = nil
    else
      response = HTTParty.get("#{FIND_BY_CITY_NAME}#{params[:city]},#{params[:country]}").body
      @results = JSON.parse(response)
      Rails.logger.info "<<<<< Response {from_ip: #{request.remote_ip}, results: #{@results}}"
    end
  end
end
