class ChangeColumsNullForProducts < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:products, :production_dste, true)
    change_column_null(:products, :expiry_date, true)
  end
end
