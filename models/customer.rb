require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize (options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"]
  end

  # Create action
  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer["id"].to_i
  end

  # Read action
  def self.all()
    sql = "SELECT * FROM customers"
    customer_hashes = SqlRunner.run(sql)
    return customer_hashes.map {|customer_hash| Customer.new(customer_hash)}
  end
  # Update action
  def update()
    sql = "UPDATE customers SET (name, funds) VALUES ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end
  # Delete action
  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
