class OrderFaxJob < Struct.new(:order)
  def perform
    result = OrderFax.order_instruction(order).deliver
    order.fax_id = result
    order.status = (result.to_i > 0)? :sending : :failed
    order.save
    true
  end
end
