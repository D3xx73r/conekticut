require "spec_helper"

describe Conekticut::Client::RequestHandler do
  describe ".has_valid_api_key?" do
    context "with valid api_key" do
      it "returns true when it was initialized" do
        Conekticut::Client::Base.public_key = "initialized"
        Conekticut::Client::RequestHandler.has_valid_api_key?.should eq true
      end
    end

    context "with invalid api_key" do
      it "returns false when it has not spaces" do
        Conekticut::Client::Base.public_key = "initial ized"
        Conekticut::Client::RequestHandler.has_valid_api_key?.should eq false
      end

      it "returns false when it was not initialized" do
        Conekticut::Client::Base.public_key = ""
        Conekticut::Client::RequestHandler.has_valid_api_key?.should eq false
      end
    end
  end

  describe ".require_ssl?" do
    context "when SSL Cert is used and it is available" do
      before :each do
        Conekticut::Client::Base.use_ssl = true
        Conekticut::Client::Base.ssl_cert_path = "spec/factories/ssl_cert.crt"
      end

      it "returns load the cert" do
        Conekticut::Client::RequestHandler.require_ssl?.should_not be_nil
      end
    end

    context "when ssl_cert is not being used" do
      before :each do
        Conekticut::Client::Base.use_ssl = false 
        Conekticut::Client::Base.ssl_cert_path = "spec/factories/ssl_cert.crt"
      end

      it "returns nil" do
        Conekticut::Client::RequestHandler.require_ssl?.should eq nil
      end
    end
  end

  describe ".format_api_path" do
    before :each do
      Conekticut::Client::Base.api_base_path = "https://api.conekta.io"
    end

    context "when .json request was not specified" do
      before :each do
        @full_request_url = Conekticut::Client::RequestHandler.format_api_path("my_request")
        @expected_request_url = "https://api.conekta.io/my_request.json"
      end

      it "returns the full request's url" do
        @full_request_url.should eq @expected_request_url
      end

      it "automatically adds .json extension" do
        @expected_request_url.should end_with ".json"
      end
    end

    context "when .json request was specified" do
      it "returns the full request's url" do
        request_url = Conekticut::Client::RequestHandler.format_api_path("my_request.json")
        request_url.should eq "https://api.conekta.io/my_request.json"
      end
    end
  end
end
