class StocksController < ApplicationController
  before_action :authenticate_user!
  def index
    @stocks = Stock.search(params[:search])
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private

  def stock_params
    params.require(:stock).permit(:name, :code, :search)
  end
end
