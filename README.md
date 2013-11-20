# Conekticut

This gem provides a simple yet extremely flexible way to interact with the [Conekta API](https://www.conekta.io/docs/api)

## Installation

Add this line to your application's Gemfile:

    gem 'conekticut'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install conekticut

## Configuring Conekticut

Conekticut can be configured in a rails initializer like so:

```ruby
  Conekticut.configure do |c|
    c.public_key = "<your_conekta_public_api_key>"
    c.private_key = "<your_conekta_public_api_key>"
    c.use_ssl = true
    c.ssl_cert_path = "<your_ssl_cert_path>"
  end
```

> If using rails you can dump this in a `conekticut.rb` initializer.

## Creating payments

The `create` method takes a hash with one of the following structures:

```ruby
  payment_info_cc = {
    "currency"=>"MXN",
    "amount"=> 20000, #the amount should be specified in cents
    "description"=>"Some Description",
    "reference_id"=>"A transaction reference",
    "card"=> {
      "number"=> 4111111111111111,
      "name"=>"Card owner",
      "exp_month"=> 12,
      "exp_year"=> 2015,
      "cvc"=> 666, #Security code
      "address"=> {
        "street1"=>"Some street",
        "city"=>"Some City",
        "state"=>"Some State",
        "country"=>"Some Country",
        "zip"=>"Some ZIP :P"
      }
    }
  }

  payment_info_oxxo = {
     "currency"=>"MXN",
     "amount"=> 20000, #the amount should be specified in cents
     "description"=>"Some Description",
     "reference_id"=>"A transaction reference",
     "cash"=> {
       "type"=>"oxxo"
     },
     "details"=> {
       "name"=>"Some name",
       "email"=>"Some email",
       "phone"=>"Some phone number"
     }
   }

   payment_info_banc = {
     "currency"=>"MXN",
     "amount"=>20000,
     "description"=>"Some description",
     "reference_id"=>"A transaction reference",
     "bank"=> {
       "type"=>"banorte"
     },
     "details"=> {
       "name"=>"Some name",
       "email"=>"Some email",
       "phone"=>"Some phone number"
     }
   }
```

After you have your payment info you can call:

```ruby
  Conekticut::Payment.create("/charges", payment_info_cc)
```

This method will return a hash which is the representation of the JSON the API returns, use the info as you see fit.

## TODO

1. Support for returning payments
2. Support for canceling payments
3. Support for consulting your history
4. Better error handling

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
