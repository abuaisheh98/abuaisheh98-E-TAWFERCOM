class CartItem
  def initialize(product_id,quantity)
    @product_id = product_id
    @quantity = quantity
  end

  def generate_hash
    {"product" => @product_id, "quantity" => @quantity}
  end
end
