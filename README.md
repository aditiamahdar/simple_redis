# Simple Redis

[![Gem Version](https://badge.fury.io/rb/simple_redis.svg)](https://badge.fury.io/rb/simple_redis)

Use Simple Redis just like you use Rails cache

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_redis', '~> 0.3.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_redis

_**Please use stable version 0.3.0**_

## Usage

### fetch
You can use key and value parameter to cache the data

```ruby
SimpleRedis.fetch(key: 'department-list', value: Department.all)
# => [{name: 'Car'}, {name: 'Fashion'}, {name: 'Gadget'}]
```
_**Please note every cached object will be converted to json format using `to_json`**_

OR You can use key and block to cache it

```ruby
SimpleRedis.fetch(key: 'department-list') do
  Department.all
end
# => [{name: 'Car'}, {name: 'Fashion'}, {name: 'Gadget'}]
```

As default we will cache data under `simple-redis-cache` collection/database, but if you need to define it yourself, simply use `db` parameter, see the example

```ruby
SimpleRedis.fetch(db: 'important-db', key: 'department-list') do
  Department.all
end
# => [{name: 'Car'}, {name: 'Fashion'}, {name: 'Gadget'}]
```

### set
You can simply just set value to a key, with this:

```ruby
SimpleRedis.set('department-list', Department.all)
# => [{name: 'Car'}, {name: 'Fashion'}, {name: 'Gadget'}]
```

### get
Or you can just get value of a key with this

```ruby
SimpleRedis.get('department-list')
# => [{name: 'Car'}, {name: 'Fashion'}, {name: 'Gadget'}]
```

### total_matches
Total matches used to see how many key matched with our keyword, e.g:

```ruby
SimpleRedis.total_matches('department/*')
# => 3
```

### delete_matched
This method remove a data based on key such as:

```ruby
SimpleRedis.delete_matched('department/fashion')
# => 1
```

OR you can use regex

```ruby
SimpleRedis.delete_matched('department/*')
# => 3
```

## Configuration

Create `simple_redis.rb` in `config/initializers` folder

```ruby
SimpleRedis.configuration do |config|
  config.host = "redis_host" # Default 'localhost'
  config.port = "redis_port" # Default 6379
  config.default_db = "redis_db" # Default '0'
end
```

And you can change those 3 configurations on the fly, example:

```ruby
SimpleRedis.fetch(db: 'important-db', key: 'department-list', host: 'redis_host', port: 'redis_port') do
  Department.all
end
# => [{name: 'Car'}, {name: 'Fashion'}, {name: 'Gadget'}]
```

## Development

## Contributing

1. Fork it ( https://github.com/aditiamahdar/simple_redis/fork )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request

This project rocks and uses MIT-LICENSE.
