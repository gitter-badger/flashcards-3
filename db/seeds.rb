# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'
require 'nokogiri'

url = 'http://www.languagedaily.com/learn-german/vocabulary/common-german-words'

doc = Nokogiri::HTML(open(url))

rows = doc.search(".rowA, .rowB")

cards = []

rows.each do |row|
  columns = row.css("td")
  cards << {:original_text => columns[1].text,
            :translated_text => columns[2].text}
end

Card.create(cards)
