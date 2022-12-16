class OrderDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id: { source: "Order.id", cond: :eq },
      status: { source: "Order.status" },
      quantity: { source: "Order.quantity", searchable: true },
      order_date: { source: "Order.order_date", cond: :like, searchable: true, sortable: true },
      user_id: { source: "Order.user_id", cond: :like },
      products: { source: "Order.products.ids", cond: :like },

    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        status: record.status,
        quantity: record.quantity,
        order_date: record.order_date,
        user_id: record.user_id,
        products: record.products.ids,
      }
    end
  end

  def get_raw_records
    Order.joins(:products => :store).where(stores: {user_id: options[:current_user]})
  end

end
