require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize (options)
    @id = options["id"].to_i if options["id"].to_i
    @customer_id = options["customer_id"].to_i if options["customer_id"].to_i
    @film_id = options["film_id"].to_i if options["film_id"].to_i

  end
  # Create action
  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  # Update action -- Ticket properties are in attr_reader.
  # def update()
  #   sql = "UPDATE tickets SET (customer_id, title_id) VALUES ($1, $2) RETURNING id"
  #   values = [@customer_id, @film_id, @id]
  #   SqlRunner.run(sql,value)
  # end

  # Read action
  def self.all()
    sql = "SELECT * FROM tickets"
    ticket_hashes = SqlRunner.run(sql)
    return ticket_hashes.map {|ticket_hash| Ticket.new(ticket_hash)}
  end
  # Delete action
  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer_hash = SqlRunner.run(sql, values).first()
    return Customer.new(customer_hash)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film_hash = SqlRunner.run(sql, values).first()
    return Film.new(film_hash)
  end


end
