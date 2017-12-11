require_relative("models/customer")
require_relative("models/film")
require_relative("models/ticket")

require("pry-byebug")

Ticket.delete_all
Customer.delete_all
Film.delete_all

#--------------------CUSTOMERS------------------------------|
customer1 = Customer.new({"name" => "Adam", "funds" => 40})
customer1.save

customer2 = Customer.new({"name" => "Eve", "funds" => 30})
customer2.save

customer3 = Customer.new({"name" => "Cain", "funds" => 6})
customer3.save

customer4 = Customer.new({"name" => "Luigi", "funds" => 45})
customer4.save


#----------------------FILMS----------------------------|
film1 = Film.new({"title" => "Passion of Christ 2", "price" => 9})
film1.save

film2 = Film.new({"title" => "King Arthur and the Square table", "price" => 7})
film2.save

film3 = Film.new({"title" => "Robin Hood, prince of strabics", "price" => 8.5})
film3.save

film4 = Film.new({"title" => "The Duck", "price" => 11})
film4.save

film5 = Film.new({"title" => "Robocop 4 the rusty cop", "price" => 9.9})
film5.save

#---------------------TICKETS------------------------------|
ticket1 = Ticket.new({"customer_id" => customer1.id, "film_id" => film1.id})
ticket1.save

ticket2 = Ticket.new({"customer_id" => customer2.id, "film_id" => film2.id})
ticket2.save

ticket3 = Ticket.new({"customer_id" => customer3.id, "film_id" => film3.id})
ticket3.save

ticket4 = Ticket.new({"customer_id" => customer4.id, "film_id" => film4.id})
ticket4.save

ticket5 = Ticket.new({"customer_id" => customer4.id, "film_id" => film5.id})
ticket5.save




binding.pry
nil
