require 'rubygems'
require 'mongo'
require 'fastercsv'

db = Mongo::Connection.new.db("govwebsites")

coll = db["websites"]
coll.remove({})

rows = FasterCSV.table("guardiandata.csv") 

rows.each do |row| 
  p row 
  coll.insert(row.to_hash())
end