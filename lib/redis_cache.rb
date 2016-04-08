require "redis"

module RedisCache
  # Set or Get cache from Redis, opts => db, key, value, block
  def self.fetch(opts={})
    host, port, db = 'localhost', 6379, 'redis-cache'
    redis = Redis.new(host: host, port: port, db: opts[:db] || db)
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

  # def self.delete_matched(key)
    # eval "for _,k in ipairs(redis.call('keys','session:*')) do redis.call('del',k) end" 0
    # redis-cli KEYS "prefix:*" | tr "\n" "\0" | xargs -0 redis-cli DEL
  # end
end
