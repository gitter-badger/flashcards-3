# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'

url = 'http://www.languagedaily.com/learn-german/vocabulary/common-german-words'

doc = Nokogiri::HTML(open(url))

rows = doc.search(".rowA, .rowB")

user = User.find_by(:email => "a@b.c") || User.new(:email => "a@b.c")

user.cards.delete_all

cards = rows.map do |row|
  columns = row.css("td")

  {
    original_text: columns[1].text,
    translated_text: columns[2].text,
    review_date: Date.today.next_day(rand(3))
  }
end

user.cards.create(cards)
