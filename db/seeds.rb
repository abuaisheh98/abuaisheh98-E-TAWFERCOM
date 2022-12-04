file = File.open(Rails.root.join("db","response.json"))
file_content = file.read

data = ActiveSupport::JSON.decode(file_content)
data["products"].each do |record|
   product = Product.new
   product.name = record["title"]
   product.price = record["price"].to_f
   product.description = record["description"]
   product.stock_quantity = record["stock"].to_i
   product.image = record["thumbnail"]
   product.store_id = 1
   unless Category.find_by(name: record["category"])
      category = Category.new
      category.name = record["category"]
      category.products << product
      category.save
   else
     exist_category = Category.find_by(name: record["category"])
     exist_category.products << product
   end
   product.save
end

