json.extract! transaction, :id, :stock_name, :quantity, :unit_price, :type, :is_fulfilled, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
