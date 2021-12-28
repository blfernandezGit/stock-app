class StocksController < ApplicationController
  before_action :authenticate_user!
  def index
    @stocks = Stock.first(10)
  end

  def show
    @stock = Stock.find(params[:id])
  end
end
