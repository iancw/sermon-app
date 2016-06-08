# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'yaml'

upcoming = YAML.load_file('upcoming.yml')
upcoming.each do |s|

  Sermon.create(Date: DateTime.strptime(s['date'], '%B %e'),
    Passage: s['passage'],
    Title: s['title'])
end