require_relative("../db/sql_runner")

class Ticket

  attr_reader id:, customer_id: film_id:

  def initialize (options)
    @id = options["id"].to_i if options["id"].to_i
    @customer_id = options["customer_id"].to_i if options["customer_id"].to_i
    @film_id = options["film_id"].to_i if options["film_id"].to_i

  end

def save()
  sql "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
  values = (@customer_id, @film_id)
  ticket_id = SqlRunner.run(sql, values).first
  @id = ticket["id"].to_i
end
