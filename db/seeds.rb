# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@client = IEX::Api::Client.new(
    publishable_token: ENV["PUBLISHABLE_TOKEN"],
    secret_token: ENV["SECRET_TOKEN"],
    endpoint: 'https://cloud.iexapis.com/v1'
)

@symbols = @client.ref_data_symbols.select {|symbol| symbol.name.length < 40}

@symbols.each do |symbol|
    if Stock.find_by(code: symbol.symbol) == nil
        stock = Stock.new(name: symbol.name, code: symbol.symbol)
        stock.save!
    end
end

User.create(email: 'stockoverflowmailer@gmail.com', password: 'P@ssw0rd', full_name: 'suppadmin', role: 'admin', status: 'accepted')