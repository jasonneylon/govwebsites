require 'rubygems'
require 'mongo'


db = Mongo::Connection.new.db("mydb")


connection = Mongo::Connection.new 

connection.database_names.each { |name| puts name }
connection.database_info.each{|name| puts name.inspect}


db.collection_names.each {|name| puts name}

coll = db["testCollection"]

# puts things

doc = {"name" => "MongoDb", "type" => "database", "count" => 1,
  "info" => {"x" => 203, "y" => '102'}}
  
coll.insert(doc)


p coll.find_one()

100.times {|i| coll.insert(:i => i)}


puts coll.count


coll.find().each {|row| puts row.inspect}

p coll.find(:i => 71).first
puts "Between 20 and 30"
coll.find(:i => {"$gt" => 20, "$lte" => 30}).each {|row| p row}




coll.find({"name" => /^M/}).each {|row| p row}

coll.create_index("i")


connection.drop_database('mydb')