require("pry")
require_relative("./models/pizza_order")
require_relative("./models/customer")

PizzaOrder.delete_all()
Customer.delete_all()


customer1 = Customer.new({
  "first_name" => "Homer",
  "last_name" => "Simpson"
  })

customer1.save()

customer2 = Customer.new({
  "first_name" => "Ned",
  "last_name" => "Flanders"
  })

customer2.save()


order1 = PizzaOrder.new({
  'customer_id' => customer1.id,
  'quantity' => 2,
  'topping' => "Pepperoni"
  })

order1.save()

order2 = PizzaOrder.new({
  'customer_id' => customer2.id,
  'quantity' => 1,
  'topping' => "Fromagio Quattro"
  })

order2.save()

order3 = PizzaOrder.new({
  'customer_id' => customer1.id,
  'quantity' => 4,
  'topping' => "Pineapple"
  })

order3.save()


binding.pry
nil
