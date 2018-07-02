class ZipsController < ApplicationController
  def index
    @high_incomes = Zip.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income DESC').limit(10)
    @low_incomes = Zip.select('zips.id, zips.a00100, zips.n1, (zips.a00100 / zips.n1) AS income').order('income ASC').limit(10)
    @highest_pops = Zip.select('id, n1').order('n1 DESC').limit(10)
  end

  def show
    @zip = Zip.find(params[:id])
    response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{@zip.id}&key=#{Rails.application.credentials.google[:api_key]}")
    @coords = response["results"][0]["geometry"]["bounds"]["northeast"]
  end
end
