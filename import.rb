require 'rubygems'
require 'mongo'
require 'fastercsv'
# require 'bigdecimal'

db = Mongo::Connection.new.db("govwebsites")

coll = db["websites"]
coll.remove({})

rows = FasterCSV.table("guardiandata.csv") 

rows.each do |row| 
  p row 
  hash = row.to_hash()
  hash.each do |key, value| 
    # p key, value 
    next unless value.is_a? String 
    next if value.include? '.uk' or value.include? '.info'
    numbers = value.scan /[-+]?\d*\.?\d+/
    if (numbers.length > 0) 
      hash[key] = value.gsub(',', '').to_f
    end
  end

  hash.each do |key, value|
    next unless key.to_s.end_with? "_" 
    hash.delete key
    new_key = key.to_s
    new_key[-1] = ''
    hash[new_key] = value
  end
  
  coll.insert(hash)
end