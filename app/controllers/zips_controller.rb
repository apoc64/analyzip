class ZipsController < ApplicationController
  def show
    @zip = Zip.find(params[:id])
  end
end
