class TransactionsController < ApplicationController
  before_action :authenticate_user!, :get_user
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = @user.transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = @user.transactions.build
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    case transaction_params[:transaction_type]
    when 'Buy'
      @transaction = @user.transactions.build(transaction_params)
      @inventory = @user.inventories.find_by(stock_id: transaction_params[:stock_id])

      if @inventory
        @inventory.update!(quantity: @inventory.quantity + transaction_params[:quantity].to_i)
      else
        @inventory = @user.inventories.build(stock_id: transaction_params[:stock_id], quantity: transaction_params[:quantity])
      end

      @transaction.is_fulfilled = true
        
      if update_cash_balance_buy
        if @transaction.save && @inventory.save && @cash.save
          redirect_to inventories_path, notice: "Buy transaction completed."
        else
          redirect_to stocks_path, notice: "Something went wrong."
        end
      else
        redirect_to({ :controller=>'transactions', :action=>'new', :transaction_type=>transaction_params[:transaction_type], :stock_id=>transaction_params[:stock_id], :price=>transaction_params[:unit_price] }, danger: "Someting went wrong.")
      end

    when 'Sell'
      @transaction = @user.transactions.build(transaction_params)
      @inventory = Inventory.find_by(stock_id: transaction_params[:stock_id])

      if @inventory.quantity > transaction_params[:quantity].to_i
        @inventory.update(quantity: @inventory.quantity - transaction_params[:quantity].to_i)
        checker = true
      elsif @inventory.quantity == transaction_params[:quantity].to_i
        @inventory.destroy
        checker = true
      end

      if checker
        if @transaction.save && @inventory.save && update_cash_balance_sell
          redirect_to inventories_path, notice: "Sell transaction completed."
        else
          @transaction.destroy
          redirect_to stocks_path, notice: "Something went wrong."
        end
      else
        redirect_to({ :controller=>'transactions', :action=>'new', :transaction_type=>transaction_params[:transaction_type], :stock_id=>transaction_params[:stock_id], :price=>transaction_params[:unit_price] }, danger: "Someting went wrong.")
      end

    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def get_user
      @user = User.find(current_user.id)
      @cash = Cash.find_by(user_id: @user.id)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:stock_id, :quantity, :unit_price, :transaction_type, :is_fulfilled, :user_id)
    end

    def update_cash_balance_buy
      @cash.update!(balance: @cash.balance - transaction_params[:quantity].to_i * Stock.find(transaction_params[:stock_id]).price)
      return !@cash.balance.negative?
    end

    def update_cash_balance_sell
      @cash.update!(balance: @cash.balance + transaction_params[:quantity].to_i * Stock.find(transaction_params[:stock_id]).price)
    end
end
