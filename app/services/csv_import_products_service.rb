class CsvImportProductsService
  require 'csv'
  def call(file)
    completed_process = 0
    percentage = 0
    file = File.open(file)
    content_count = (File.open(file).count - 1).to_f
    csv = CSV.parse(file, headers: true)
    csv.each do |row|
      completed_process += 1
      Product.upsert({ id: row["id"], name: row["name"], store_id: row["store_id"], price: row["price"].to_f, stock_quantity: row["stock_quantity"].to_i, description: row["description"], image: row["image"] })
      percentage = ((completed_process / content_count) * 100).round(2)
      p '==============================',percentage,content_count,completed_process, '==============================='
      ActionCable.server.broadcast 'ProgressWayChannel', percentage.to_s
      end

  end
end
