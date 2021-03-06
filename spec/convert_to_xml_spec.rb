require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "wishlist app" do
  context "xml" do
    before(:each) do
      URI.stub!(:encode)
      URI.should_receive(:encode).exactly(1).times.and_return(File.dirname(__FILE__) + '/support/wishlist.html')

      get '/exitbutton'     
    end

    it "should produce valid xml" do
      Nokogiri::XML(last_response.body).errors.should == Array.new
    end

    it "should find an app id" do
      last_response.body.should match /45740/
    end

    it "should fine a app name" do
      last_response.body.should match /Dead Rising 2/    
    end

    it "should find a store link" do
      last_response.body.should match /http\:\/\/store.steampowered.com\/app\/45740/   
    end

    it "should fine a date_added" do
      last_response.body.should match /November 24th\, 2010/    
    end    
  end

  context "default route" do
    it "should have an empty page" do
      get '/'
      last_response.body.size.should be 0
    end
  end

end