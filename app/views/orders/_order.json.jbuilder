json.extract! order, :id, :status, :quantity, :order_date, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)
