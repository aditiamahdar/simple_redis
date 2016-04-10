# Simple Redis

[![Gem Version](https://badge.fury.io/rb/simple_redis.svg)](https://badge.fury.io/rb/simple_redis)

Use Simple Redis just like you use Rails cache

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_redis'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_redis

## Usage

### fetch
You can use key and value parameter to cache the data

```ruby
SimpleRedis.fetch(key: 'department-list', value: departments)
```

OR You can use key and block to cache it

```ruby
SimpleRedis.fetch(key: 'department-list') do
  Department.all
end
```

As default we will cache data under `simple-redis-cache` collection/database, but if you need to define it yourself, simply use `db` parameter, see the example

```ruby
SimpleRedis.fetch(db: 'important-db', key: 'department-list') do
  Department.all
end
```

### set
You can simply just set value to a key, with this:

```ruby
SimpleRedis.set('department-list', departments)
```

### get
Or you can just get value of a key with this

```ruby
SimpleRedis.get('department-list')
```

## Configuration

Create `simple_redis.rb` in `config/initializers` folder

```ruby
SimpleRedis.configuration do |config|
  config.host = "redis_host" # Default 'localhost'
  config.port = "redis_port" # Default 6379
  config.default_db = "redis_db_name" # Default 'simple-redis-cache'
end
```

## Development

## Contributing

1. Fork it ( https://github.com/aditiamahdar/simple_redis/fork )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request

This project rocks and uses MIT-LICENSE.
