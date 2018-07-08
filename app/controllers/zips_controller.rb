class ZipsController < ApplicationController
  def index
    @zips = ZipsIndexPresenter.new
  end

  def show
    @zip = ZipPresenter.new(params[:id])
    # @zip = Zip.find(params[:id])
    # response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{@zip.id}&key=#{Rails.application.credentials.google[:api_key]}")
    # @coords = response["results"][0]["geometry"]["location"]
  end
end
