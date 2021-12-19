# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@client = IEX::Api::Client.new(
    publishable_token: 'pk_2e688a1cf8f444d3a05bc370ffe80a52',
    secret_token: 'sk_2265ce2d60a54e578dd7b80fc729a0c7',
    endpoint: 'https://cloud.iexapis.com/v1'
)

@symbols = @client.ref_data_symbols.select {|symbol| symbol.name.length < 50}

@symbols.each do |symbol|
    if Stock.find_by(code: symbol.symbol) == nil
        stock = Stock.new(name: symbol.name, code: symbol.symbol)
        stock.save!
    end
end