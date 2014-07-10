require "spec_helper"
require "json"

describe Conekticut::Client::Payment do
  before :each do
    Conekticut.configure do |c|
      c.public_key = "1tv5yJp3xnVZ7eK67m4h"
      c.private_key = "1tv5yJp3xnVZ7eK67m4h"
      c.ssl_cert_path = "spec/factories/ssl_cert.crt"
      @payments_status_list = ["paid", "pending_payment"]
    end
  end

  describe ".create" do
    context "when incorrect data was submited" do
      it "send request to conekta servers" do
        payment_info = { "card"=> {} }
        response = Conekticut::Client::Payment.create("charges", payment_info)
        response["status"].should eq 422
      end
    end

    context "when correct data was submited" do
      context "with credit card payment" do
        it "returns a json with status equal paid" do
          payment_info = {
            "currency"=>"MXN",
            "amount"=> 20000,
            "description"=>"Stogies",
            "reference_id"=>"9839-wolf_pack",
            "card"=> {
              "number"=> 4111111111111111,
              "name"=>"Thomas Logan",
              "exp_month"=> 12,
              "exp_year"=> 2015,
              "cvc"=> 666,
              "address"=> {
                "street1"=>"250 Alexis St",
                "city"=>"Red Deer",
                "state"=>"Alberta",
                "country"=>"Canada",
                "zip"=>"T4N 0B8"
              }
            }
          }

          response = Conekticut::Client::Payment.create("charges", payment_info)
          @payments_status_list.should include(response["status"])
        end
      end

      context "with bank payment" do
        it "returns a json with status equal pending_payment" do
          payment_info = {
            "currency"=>"MXN",
            "amount"=>20000,
            "description"=>"Stogies",
            "reference_id"=>"9839-wolf_pack",
            "bank"=> {
              "type"=>"bank"
            },
            "details"=> {
              "name"=>"Wolverine",
              "email"=>"logan@x-men.org",
              "phone"=>"403-342-0642"
            }
          }

          response = Conekticut::Client::Payment.create("charges", payment_info)
          @payments_status_list.should include(response["status"])
        end
      end

      context "with oxxo payment" do
        it "returns a json with status equal pending_payment" do
          payment_info = {
            "currency"=>"MXN",
            "amount"=>20000,
            "description"=>"Stogies",
            "reference_id"=>"9839-wolf_pack",
            "cash"=> {
              "type"=>"oxxo"
            },
            "details"=> {
              "name"=>"Wolverine",
              "email"=>"logan@x-men.org",
              "phone"=>"403-342-0642"
            }
          }

          response = Conekticut::Client::Payment.create("charges", payment_info)
          @payments_status_list.should include(response["status"])
        end
      end
    end
  end
end
