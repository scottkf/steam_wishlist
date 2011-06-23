require 'sinatra/base'

require 'nokogiri'
require 'open-uri'

class Wishlist < Sinatra::Base
  get '/' do 
    ''
  end

  get '/:profile' do
    doc = Nokogiri::HTML(open(URI.encode("http://steamcommunity.com/id/#{params[:profile]}/wishlist/?xml=1")))
    content_type 'text/xml'
  
    builder do |xml|
      xml.instruct!
      xml.games do      
        doc.search('.wishlistRow').each do |game|
          app_id = game.attr('id').match(/game_([\d]+)/).captures.first.to_i
          app_name = game.search('h4').text
          date_added = game.text.match(/Added on (.* [\d]{4})/)[1]
          store_link = game.search('.storepage_btn_ctn a').attr('href')
          xml.game do
            xml.app_id app_id
            xml.app_name app_name
            xml.date_added date_added
            xml.store_link store_link
          end
        end
      end
    end
  end
end
