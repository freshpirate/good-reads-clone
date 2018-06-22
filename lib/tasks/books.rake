require 'net/http'

namespace :books do
    desc 'Generate random books using Faker'

    task generate: :environment do

        99.times do |i|
            title = Faker::Book.title
            author = Faker::Book.author
            publisher = Faker::Book.publisher
            isbn_number = Faker::IDNumber.invalid
            cover = "https://loremflickr.com#{Net::HTTP::get_response(URI("https://loremflickr.com/311/475"))['location']}"
            published_year = Faker::Date.backward(10000).year
            language = "English"
            synopsis = Faker::Lorem.paragraph(3, false, 7)
            average_rating = Faker::Number.decimal(1,5)
            rating_count = 1

            book = Book.create!(
                title: title,
                author: author,
                publisher: publisher,
                isbn_number: isbn_number,
                cover: cover,
                published_year: published_year,
                language: language,
                synopsis: synopsis,
                average_rating: average_rating,
                rating_count: rating_count
            )

            puts book.as_json
        end
    end
end
