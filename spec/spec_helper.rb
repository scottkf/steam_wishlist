require File.dirname(__FILE__) + '/../wishlist'

require 'rspec'
require 'rack/test'


RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  def app
    Wishlist
  end
  
end
