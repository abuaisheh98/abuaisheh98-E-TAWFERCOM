class CsvImportProductsService
  require 'csv'
  def call(file)
    file = File.open(file)
    csv = CSV.parse(file, headers: true)
    csv.each do |row|
      result = Product.where(:name => row["name"], :store_id => row["store_id"]).first_or_create
      result.price = row["price"].to_f
      result.stock_quantity = row["stock_quantity"].to_i
      result.description = row["description"]
      result.production_dste = row["production_dste"]
      result.expiry_date = row["expiry_date"]
      result.image = row["image"]
      result.save
      end
  end
end
