require 'pry'

class Pokemon

# database_connection = SQLite3::Database.new('db/my_database.db')

  attr_accessor :id, :name, :type, :hp, :db

  @@all = []

  def initialize(id:, name:, type:, hp: nil, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @@all << self
    end

  def self.all
    @@all
  end

# binding.pry

  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp = ?;", hp)
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",  name, type)
  end

  def self.find(id, db)
    new_p = db.execute("SELECT * FROM pokemon WHERE id = #{id}").flatten
    pop = Pokemon.new(id: new_p[0], name: new_p[1], type: new_p[2], hp: new_p[3], db: db)
  end



end

# Now that we got every pokemon we want to get them ready to fight. (Did you really think you and Arel weren't going to have a battle after capturing every pokemon?) But if they battle we need to keep track of their hp (health power). And the only way to do that is to alter the database. What would be perfect is a sql query that adds an hp column and default value of 60 to every row. That sql command should be put into a migration file in db/.
#
# Once the hp column is set up there should be an instance method called alter_hp that will allow us to change a specific pokemon's health to a new hp. It will need to take a new health power as a parameter.


# it "knows that a pokemon have a default hp of 60" do
#   # The find method should create a new Pokemon object with an id, type, name AND hp after selecting their row from the database by their id number.
#   # remember to also update the initialize method to accept an argument of hp that defaults to nil if not set (so it still passes the non-bonus tests)
#   expect(@db.execute("SELECT hp FROM pokemon").flatten.first).to eq(60)
# end
