class Stock < ApplicationRecord
    require 'iex-ruby-client'

    has_many :transactions

    validates :code, uniqueness: true

    def price
        @client = IEX::Api::Client.new(
            publishable_token: ENV["PUBLISHABLE_TOKEN"],
            secret_token: ENV["SECRET_TOKEN"],
            endpoint: 'https://cloud.iexapis.com/v1'
        )
        Rails.cache.fetch("#{cache_key_with_version}/price", expires_in: 24.hours) do
            @client.quote(code).latest_price
        end
    end

    def self.search(search)
        if search
            searched_stocks = Stock.where("name ILIKE ? OR code ILIKE ?", "%#{search}%", "%#{search}%")
            if searched_stocks.length > 0
                @stocks = searched_stocks.first(5)
            else
                @stocks = Stock.first(5)
            end
        else
            @stocks = Stock.first(5)
        end
    end
end