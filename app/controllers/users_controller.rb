class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update ]

    def index
        @users = User.where(role: 'trader').order('full_name asc')
        # @pending = User.where(status: 'pending')
        # @accepted = User.where(status: 'accepted')
        # @rejected = User.where(status: 'rejected')
    end

    def show

    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                WelcomeMailer.send_welcome_email(@user).deliver
                format.html { redirect_to client_path(@user), notice: 'Client account was successfully created.' }
            else
                format.html { render :new, status: :unprocessable_entity } #TODO: change redirect
            end
        end
    end

    def edit

    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to client_path(@user), notice: "Client details successfully updated." }
            else
                format.html { render :edit, status: :unprocessable_entity } #TODO: change redirect
            end
        end
    end

    def client_action
        @selected_users = User.where(id: params[:user_ids])
        case params[:client_action]
        when 'Accept'
        respond_to do |format|
            if @selected_users.update(status: 'accepted')
                @selected_users.each do |user|
                    AcceptedMailer.send_acceptance_email(user).deliver
                end
                format.html { redirect_to client_list_path, notice: "Client Accounts successfully accepted." }
            else
                format.html { render :edit, status: :unprocessable_entity } #TODO: change redirect
            end
        end
        when 'Reject'
            respond_to do |format|
                if @selected_users.update(status: 'rejected')
                    format.html { redirect_to client_list_path, notice: "Client Accounts successfully rejected." }
                else
                    format.html { render :edit, status: :unprocessable_entity } #TODO: change redirect
                end
            end
        end 
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.require(:user).permit(:full_name, :password, :email, :role, :password_confirmation, :status)
    end

end
