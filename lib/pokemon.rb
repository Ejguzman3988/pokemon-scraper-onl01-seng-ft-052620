class Pokemon
    attr_accessor :name, :type, :id
    attr_reader :db
    

    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
        INSERT INTO pokemon (name, type) VALUES ( ?,? )
        SQL
        new_pokemon = self.new(name: name, type: type, db: db)
        db.execute(sql, name, type)
        new_pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end
    
    def self.find(id, db)
        sql = <<-SQL
        SELECT * FROM pokemon  
        WHERE id = ?
        SQL
        data = db.execute(sql,id)[0]
        poke = self.new(name: data[1], type: data[2], db: db)
        poke.id = id
        poke
    end
end
