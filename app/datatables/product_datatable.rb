class ProductDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Product.id", cond: :eq },
      name: { source: "Product.name", cond: :like },
      price: { source: "Product.price", cond: :like, searchable: true },
      description: { source: "Product.description", cond: :like, searchable: true, sortable: true }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        name: record.name,
        price: record.price,
        description: record.description
      }
    end
  end

  def get_raw_records
    Product.all
  end

end
