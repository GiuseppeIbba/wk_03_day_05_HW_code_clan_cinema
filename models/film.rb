require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize (options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"]
  end
  # Create action
  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film["id"].to_i
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
# Update action
def update()
  sql = "UPDATE films SET (title, price) VALUES ($1, $2) WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end



end
