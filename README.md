# Installation

```ruby
gem install cryptopay
```


or your Gemfile:

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
                                callback_url: 'https://cryptopay.me'
```
now invoice object is hash with next attributes
```ruby
uuid: 'cf47603e-8e86-413d-86f2-0cf94fe05683',
description: 'test description',
status: 'pending',
btc_price: 0.0055,
btc_address: '16KcaBuNbHXhTweJspFkSku2nmvvyV8NoL',
short_id: 'CF47603E',
callback_params: nil,
id: 'test',
price: 2.32,
currency: 'GBP',
created_at: 1387305401,
valid_till: 1387306001
```

You can save `uuid` and use this later for update invoice status:
```ruby
Cryptopay.invoice invoice['uuid']
```


# Errors handle
classic ruby-way
```ruby
 begin
    params = Cryptopay.new_invoice id: 'test',
                                 price: 0
    
    rescue  Cryptopay::Error => e
      e.errors['price']
      #["must be greater than 0"]
    end

```
