# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Book.create(:title => 'Harry Potter', :author => 'Joan Roaling')
Book.create(:title => '7 habits', :author => 'Stephen Covey')
Book.create(:title => 'Lord from Earth', :author => 'Sergey Lukianenko')
Book.create(:title => 'Lord of the Rings', :author => 'Baba baba')