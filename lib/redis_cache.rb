require "redis"

module RedisCache
  class << self
    attr_accessor :host
    attr_accessor :port
    attr_accessor :default_db
  end

  def self.configuration(&block)
    yield self
  end

  # Set or Get cache from Redis, opts => db, key, value, block
  def self.fetch(opts={})
    redis = Redis.new(host: host || 'localhost', port: port || 6379, db: opts[:db] || default_db || 'redis-cache')
    result = redis.get opts[:key]
    result = self.cache(redis, opts, block_given? ? yield.inspect : nil) if result.nil?
    begin eval result rescue result end
  end

  def self.cache(redis, opts, inspected_yield)
    if opts[:value]
      redis.set opts[:key], opts[:value]
      opts[:value]
    else
      redis.set(opts[:key], inspected_yield)
      inspected_yield
    end
  end

  # def self.set
  # end

  # def self.get
  # end

  # def self.delete_matched(key)
    # eval "for _,k in ipairs(redis.call('keys','session:*')) do redis.call('del',k) end" 0
    # redis-cli KEYS "prefix:*" | tr "\n" "\0" | xargs -0 redis-cli DEL
  # end
end
