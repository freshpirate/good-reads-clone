namespace :mail do
    desc 'Send top rated books to users via mail'

    task top_rated: :environment do
        top_rated_count = 10

        rating_hashmap = Hash.new()

        Book.all.each do |book|
            rating_hashmap[book] = book.average_rating
        end

        top_rated_list = rating_hashmap.values.sort
        top_rated_books = []

        (1..top_rated_count).each do |i|
            if top_rated_list.length == 0
                break
            end
            
            book = rating_hashmap.index(top_rated_list.pop)
            top_rated_books.push(book)
            rating_hashmap.delete(book)
        end

        UserMailer.top_rated(top_rated_books).deliver!
    end
end
