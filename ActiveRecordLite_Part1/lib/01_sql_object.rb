require 'byebug'
require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    unless @arr
      @arr = DBConnection.execute2(<<-SQL)
        SELECT 
          *
        FROM 
          -- #{@table_name}
          #{self.table_name}
       SQL
       @arr = @arr.first
       @arr.map! {|el| el.to_sym }
     end
     @arr
     
  end

  def self.finalize!
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    name = ""
    self.to_s.each_char do |chr|
      if chr == chr.upcase
        name+= "_#{chr.downcase}" 
      else 
        name += chr 
      end 
    end
      @table_name = "#{name[1..-1]}s"
  end

  def self.all
    # ...
    DBConnection.instance.execute(<<-SQL)
       SELECT * FROM self.table_name 
    SQL
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    
    cat = DBConnection.instance.execute(<<-SQL, id)
       SELECT * FROM cats 
       WHERE id = ?
    SQL
    p cat
     p self.class.new(cat.first)
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
