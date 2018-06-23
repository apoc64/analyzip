class ZipsController < ApplicationController

  def show
    @zip = Zip.find(params[:id])
    response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{@zip.id}&key=#{Rails.application.credentials.google[:api_key]}")
    @coords = response["results"][0]["geometry"]["bounds"]["northeast"]
  end
end
