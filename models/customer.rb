require_relative("../db/sql_runner")
require_relative("ticket")
class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize (options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"].to_i if options["funds"]
  end

  # Create action
  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  # Update action
  def update()
    sql = "UPDATE customers SET (name, funds) VALUES ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  # Read action
  def self.all()
    sql = "SELECT * FROM customers"
    customer_hashes = SqlRunner.run(sql)
    return customer_hashes.map {|customer_hash| Customer.new(customer_hash)}
  end

  # Delete action
  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON
           tickets.film_id = films.id WHERE tickets.customer_id = $1"
    values = [@id]
    film_hashes = SqlRunner.run(sql, values)
    result = film_hashes.map{|film_hash| Film.new(film_hash)}
    return result
  end

  def films_booked()
    sql = "SELECT  customers.name, films.title FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    INNER JOIN customers
    ON customers.id = tickets.customer_id WHERE tickets.customer_id = $1"
    values = [@id]
    film_hashes = SqlRunner.run(sql, values)
    result = film_hashes.map{|film_hash| film_hash}
    return result
  end


  def self.map_items(customer_hashes)
    result = customer_hashes.map {|customer_hash| Customer.new(customer_hash)}
    return result
  end

  # def films_booked()
  #   sql = "SELECT  customers.name, films.title FROM films
  #   INNER JOIN tickets
  #   ON tickets.film_id = films.id
  #   INNER JOIN customers
  #   ON customers.id = tickets.customer_id WHERE tickets.customer_id = $1"
  #   values = [@id]
  #   film_hashes = SqlRunner.run(sql, values)
  #   result =  film_hashes.map{|film_hash| Film.new(film_hash)}
  #   return result
  # end















end
