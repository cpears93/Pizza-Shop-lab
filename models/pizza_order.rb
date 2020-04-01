require_relative('../db/sql_runner')
require_relative('./customer')

class PizzaOrder

  attr_accessor :topping, :quantity, :customer_id
  attr_reader :id

  def initialize(options)
    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
  end

  def save()
    sql = "INSERT INTO pizza_orders (customer_id, topping, quantity)
    VALUES ($1, $2, $3) RETURNING id"
    values = [@customer_id, @topping, @quantity]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def update()
    sql = "UPDATE pizza_orders SET (customer_id, topping, quantity)
    = ($1, $2, $3) WHERE id = $4"
    values = [@customer_id, @topping, @quantity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM pizza_orders where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM pizza_orders"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM pizza_orders WHERE id = $1"
    values = [id]
    order = SqlRunner.run(sql, values).first
    return nil if order == nil
    return PizzaOrder.new(order)
  end

  def self.all()
    sql = "SELECT * FROM pizza_orders"
    orders = SqlRunner.run(sql)
    return orders.map { |order| PizzaOrder.new(order) }
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first()
    return Customer.new(customer)
  end

end
