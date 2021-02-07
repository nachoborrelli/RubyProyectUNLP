# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create email:"prueba@hotmail.com", name: "jose" , password: "123456", password_confirmation: "123456"

(1..15).each do |i|
  book = Book.create title: "Book #{i}", user_id: user.id

  1.upto(rand(1..20)) do |j|
    book.notes.create title: "Note #{j}", content: "Content for note #{j}. <h1> Prueba de html andando </h1>", user_id: user.id
  end

end