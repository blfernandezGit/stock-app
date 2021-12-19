class StocksController < ApplicationController
  def index
    @stocks = Stock.first(10)
  end

  def show
    @stock = Stock.find(params[:id])
  end
end
