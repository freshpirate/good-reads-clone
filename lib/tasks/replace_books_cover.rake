require 'net/http'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


namespace :replace_books_cover do
    desc 'Replace books cover with appropriate url'

    task generate: :environment do

        range = 0..1084

        Book.all.each do |book|
            loop do
                cover_url = "https://picsum.photos/311/475?image=#{Random.rand(range)}"
            
                test = Net::HTTP::get_response(URI(cover_url))

                if test.as_json["content-type"][0] == "image/jpeg"
                    book.cover = cover_url
                    book.save
                    break
                else
                    puts JSON.parse(test.body)
                end
            end

            puts ""
            puts book.cover
        end
    end
end
