require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongo'

class Numeric
  def to_display()
    self.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
  end
  
  def to_money()
   '&pound;' + to_display
  end 
end

class NilClass
  def to_money()
  end
end

get '/' do
  db = Mongo::Connection.new.db("govwebsites")
  @websites = db["websites"].find({}, {:sort => [["website","ascending"]]})
  haml :index
end