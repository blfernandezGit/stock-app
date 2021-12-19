# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@client = IEX::Api::Client.new(
    publishable_token: 'Tpk_5c8fa9d8178a464dbf82666808a433cb',
    endpoint: 'https://sandbox.iexapis.com/v1'
)

@symbols = @client.ref_data_symbols.select {|symbol| symbol.name.length < 40}

@symbols.each do |symbol|
    if Stock.find_by(code: symbol.symbol) == nil
        stock = Stock.new(name: symbol.name, code: symbol.symbol)
        stock.save!
    end
end