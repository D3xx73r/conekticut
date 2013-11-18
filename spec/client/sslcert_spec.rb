require "spec_helper"

describe Conekticut::SSLCert do
  describe "instance methods" do
    describe "#to_path" do
      context "when path was not specified" do
        before :each do
          Conekticut::Client::Base.ssl_cert_path = "my_ssl_cert_path"  
        end

        it " returns Base.ssl_cert_path" do
          ssl_cert_path = Conekticut::Client::Base.ssl_cert_path = "my_ssl_cert_path"  
          Conekticut::SSLCert.new.to_path.should eq ssl_cert_path
        end
      end
  
      context "when path was specified" do
        it "should load the expected cert" do
          ssl_cert_path = Conekticut::Client::Base.ssl_cert_path = "my_ssl_cert_path"  
          Conekticut::SSLCert.new("expected_cert").to_path.should eq "expected_cert" 
        end
      end
    end
  end
end
