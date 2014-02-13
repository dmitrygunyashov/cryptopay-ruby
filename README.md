# Cryptopay
Easily accept Bitcoin payment with Cryptopay Payment API

Before you will be able to start using this gem, you will need to obtain an API key in Account - Merchant Tools - Settings.


# Installation

```ruby
gem install cryptopay
```


or in your Gemfile:

```ruby
gem 'cryptopay'`
```

And set your api key.

```ruby
Cryptopay.key = '38a193829970502311698ce3f9cd5abb'
```

# Basic Usage

To create an invoice:

```ruby
invoice = Cryptopay.new_invoice id: 'test',
                                price: 2.32,
                                currency: 'GBP',
                                description: 'test description',
                                success_redirect_url: 'https://cryptopay.me',
                                callback_url: 'https://cryptopay.me',
                                callback_params: {
                                         customer_id: "12389",
                                         array_params: ['Black', '36' 'XL'],
                                         nested_hash: {
                                             validations_hash: "other",
                                             array_params_again: ['test1', 'test2' 'test3']
                                         }
                                     }
```
now invoice object is hash with next attributes
```ruby
uuid: 'cf47603e-8e86-413d-86f2-0cf94fe05683',
description: 'test description',
status: 'pending',
btc_price: 0.0055,
btc_address: '16KcaBuNbHXhTweJspFkSku2nmvvyV8NoL',
short_id: 'CF47603E',
callback_params: {
    validations_hash: "SUPERSECRETHASH",
    array_params: ['test1', 'test2' 'test3'],
    nested_hash: {
        validations_hash: "other",
        array_params_again: ['test1', 'test2' 'test3']
   }
},
id: 'test',
price: 2.32,
currency: 'GBP',
created_at: 1387305401,
valid_till: 1387306001,
url: "http://cryptopay.me/orders/cf47603e-8e86-413d-86f2-0cf94fe05683/d"
```

You can save `uuid` and use this later to update invoice status:
```ruby
Cryptopay.invoice invoice['uuid']
```


# Errors handle
Error handling is done in classic ruby way:
```ruby
 begin
    params = Cryptopay.new_invoice id: 'test',
                                 price: 0
    
    rescue  Cryptopay::Error => e
      e.errors['price']
      #["must be greater than 0"]
    end

```
