class CashesController < ApplicationController
  before_action :authenticate_client!, :get_user, :set_cash

  def edit
  end

  def update
    respond_to do |format|
      if @cash.update(balance: (@cash.balance*100).to_i/100 + (cash_params[:last_cash_in_amt].to_d*100).to_i/100, last_cash_in_amt: (cash_params[:last_cash_in_amt].to_d*100).to_i/100)
        format.html { redirect_to inventories_path, notice: "Cash in was successful." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_user
      @user = User.find(current_user.id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_cash
      @cash = Cash.find_by(user_id: @user.id)
    end

    # Only allow a list of trusted parameters through.
    def cash_params
      params.require(:cash).permit(:balance, :last_cash_in_amt, :user_id)
    end
end
