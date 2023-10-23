# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
10.times do
    Article.create(
        title: Faker::Lorem.sentence(word_count: 3),
        body: Faker::Lorem.paragraph(sentence_count: 2),
        imageurl: Faker::Internet.url,
        source: Faker::Lorem.word,
        article_url: Faker::Internet.url,
        article_id: Faker::Number.number(digits: 10),
        created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
    User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: "password",
        phone: Faker::PhoneNumber.cell_phone,
        admin: false,
        created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
    Comment.create(
        commenter: Faker::Name.name,
        body: Faker::Lorem.paragraph(sentence_count: 2),
        article_id: Article.last.id,
        like: 1,
        dislike: 0,
        created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
    )
    end