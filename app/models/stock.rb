class Stock < ApplicationRecord
    require 'iex-ruby-client'

    has_many :transactions

    validates :code, uniqueness: true

    def price
        @client = IEX::Api::Client.new(
            publishable_token: 'pk_2e688a1cf8f444d3a05bc370ffe80a52',
            secret_token: 'sk_2265ce2d60a54e578dd7b80fc729a0c7',
            endpoint: 'https://cloud.iexapis.com/v1'
        )
        Rails.cache.fetch("#{cache_key_with_version}/price", expires_in: 24.hours) do
            @client.quote(code).latest_price
        end
    end
end