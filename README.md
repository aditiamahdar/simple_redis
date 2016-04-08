# Redis Cache

[![Gem Version](https://badge.fury.io/rb/redis_cache.svg)](https://badge.fury.io/rb/redis_cache)

Use Redis cache just like you use Rails cache

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis_cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis_cache

## Usage

You can use key and value parameter to cache the data

```ruby
RedisCache.fetch(key: 'department-list', value: departments)
```

OR You can use key and block to cache it

```ruby
RedisCache.fetch(key: 'department-list') do
  Department.all
end
```

As default we will cache data under `redis-cache` collection/database, but if you need to define it yourself, simply use `db` parameter, see the example

```ruby
RedisCache.fetch(db: 'important-db', key: 'department-list') do
  Department.all
end
```

## Development

## Contributing

1. Fork it ( https://github.com/aditiamahdar/redis_cache/fork )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request

This project rocks and uses MIT-LICENSE.
