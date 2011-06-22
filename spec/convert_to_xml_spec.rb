require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "xml app" do
  it "should find an app id" do
    URI.stub!(:encode)
    URI.should_receive(:encode).exactly(1).times.and_return(File.dirname(__FILE__) + '/support/wishlist.html')
    
    get '/exitbutton' 
    last_response.body.should == 'Welcome to my page!' 
  end
end