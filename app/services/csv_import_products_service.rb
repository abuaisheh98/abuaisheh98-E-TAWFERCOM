class CsvImportProductsService
  require 'csv'
  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true)
    csv.each do |row|
      Product.upsert({ id: row["id"], name: row["name"], store_id: row["store_id"], price: row["price"].to_f, stock_quantity: row["stock_quantity"].to_i, description: row["description"], image: row["image"] })
      end
  end
end
