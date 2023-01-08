class ImportingJob < ApplicationJob
  queue_as :default
  require 'csv'

  def perform(csv_string)
    rows = CSV.parse(csv_string)

    # Convert the array of rows back into a CSV string
    csv_string = CSV.generate do |csv|
      rows.each do |row|
        csv << row
      end
    end

    # Create a new CSV file and write the CSV string to it
    File.open('file.csv', 'w') do |file|
      file.write(csv_string)
    end

    CsvImportProductsService.new.call('file.csv')
    puts "+++++++++++++++++++++++++++ DONE ++++++++++++++++++++++++++++++++"
  end
end
