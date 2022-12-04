json.extract! product, :id, :name, :price, :description, :production_dste, :expiry_date, :image, :stock_quantity, :store_id, :created_at, :updated_at
json.url product_url(product, format: :json)
