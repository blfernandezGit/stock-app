class TransactionsController < ApplicationController
  before_action :authenticate_client!, :get_user

  # GET /transactions or /transactions.json
  def index
    @transactions = @user.transactions
  end

  # GET /transactions/new
  def new
    @transaction = @user.transactions.build
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = @user.transactions.build(transaction_params)
    @inventory = @user.inventories.find_by(stock_id: transaction_params[:stock_id])
    @cash = Cash.find_by(user_id: @user.id)
    @original_cash = @cash.balance

    case transaction_params[:transaction_type]
    when 'Buy'
      if @inventory
        @original_quantity = @inventory.quantity
        @inventory.update!(quantity: @inventory.quantity + transaction_params[:quantity].to_i)
      else
        @inventory = @user.inventories.build(stock_id: transaction_params[:stock_id], quantity: transaction_params[:quantity])
      end

      @transaction.is_fulfilled = true
        
      if update_cash_balance_buy
        if @transaction.save && @inventory.save
          redirect_to inventories_path, notice: "Buy transaction completed."
        else
          @transaction.destroy
          @inventory.quantity = @original_quantity
          @cash.balance = @original_cash
          redirect_to stocks_path, danger: "Something went wrong."
        end
      else
        redirect_to({ :controller=>'transactions', :action=>'new', :transaction_type=>transaction_params[:transaction_type], :stock_id=>transaction_params[:stock_id], :price=>transaction_params[:unit_price] }, danger: "Not enough cash. Please cash in or lower the quantity to buy.")
      end

    when 'Sell'
      @original_quantity = @inventory.quantity
      if @inventory.quantity > transaction_params[:quantity].to_i
        @inventory.update!(quantity: @inventory.quantity - transaction_params[:quantity].to_i)
        checker = true
      elsif @inventory.quantity == transaction_params[:quantity].to_i
        @inventory.destroy
        checker = true
      end

      if checker
        if @transaction.save && update_cash_balance_sell
          redirect_to inventories_path, notice: "Sell transaction completed."
        else
          @transaction.destroy
          @inventory.quantity = @original_quantity
          @cash.balance = @original_cash
          redirect_to stocks_path, danger: "Something went wrong."
        end
      else
        redirect_to({ :controller=>'transactions', :action=>'new', :transaction_type=>transaction_params[:transaction_type], :stock_id=>transaction_params[:stock_id], :price=>transaction_params[:unit_price] }, danger: "Quantity to sell should not be greater than your available quantity.")
      end

    end
  end

  private
    def get_user
      @user = User.find(current_user.id)
    end

    def transaction_params
      params.require(:transaction).permit(:stock_id, :quantity, :unit_price, :transaction_type, :is_fulfilled, :user_id)
    end

    def update_cash_balance_buy
      @expense = transaction_params[:quantity].to_i * Stock.find(transaction_params[:stock_id]).price
      return false if @cash.balance < @expense
      @cash.update!(balance: @cash.balance - @expense)
    end

    def update_cash_balance_sell
      @cash.update!(balance: @cash.balance + transaction_params[:quantity].to_i * Stock.find(transaction_params[:stock_id]).price)
    end
end
