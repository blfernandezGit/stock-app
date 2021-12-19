class HomeController < ApplicationController
    before_action :authenticate_user!, only: %i[ show ]
    def index
        render :index
    end

    def show

    end
end
