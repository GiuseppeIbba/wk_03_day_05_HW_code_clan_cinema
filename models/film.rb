require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize (options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"].to_i if options["price"]
  end
  # Create action
  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film["id"].to_i
  end

  # Update action
  def update()
    sql = "UPDATE films SET (title, price) VALUES ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  # Read action
  def self.all()
    sql = "SELECT * FROM films"
    film_hashes = SqlRunner.run(sql)
    return film_hashes.map {|film_hash| Film.new(film_hash)}
  end

  # Delete action
  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customer_hashes = SqlRunner.run(sql, values)
    return customer_hashes.map {|customer_hash| Customer.new(customer_hash)}
  end






end
