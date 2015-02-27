# Logstash::Client

Very Simple Gem to fetch data from a logstash index with pagination. It could be very helpful when you need to proccess data (nginx logs for example ).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logstash-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logstash-client

## Usage

Initialize the client :

```ruby
 client = Logstash::Client.new("https://logcenter.numidiasoft.io") do |logcenter|
   logcenter.login = "me"   
   logcenter.password = "me"
   logcenter.result_size = 2 # size of the result data
   logcenter.prefix_path = "es"  # prefix add to the path of http request
   logcenter.logger = true # log requests to STDOUT
 end 
```
Load the first page of the table : 

```ruby
  index = "index_name"
  date = "2015-02-24"        
  ago = "24h # The units supported are y (year), M (month), w (week), d (day), h (hour), m (minute), and s (second).
  response = client.index(index, date, ago)
```
Get next pages

```ruby
 while response.body.size > 0 do
   response = response.next_page
   puts reponse.body
 end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/logstash-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
