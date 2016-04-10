require "redis"

module SimpleRedis
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
    redis = get_redis(opts)
    result = redis.get opts[:key]
    result = cache(redis, opts[:key], block_given? ? yield.inspect : opts[:value].inspect) if result.nil?
    get_result(result)
  end

  def self.set(key, value, opts={})
    redis = get_redis(opts)
    result = cache redis, key, value.inspect
    get_result(result)
  end

  def self.get(key, opts={})
    redis = get_redis(opts)
    result = redis.get key
    get_result(result)
  end

  # def self.delete_matched(key)
    # eval "for _,k in ipairs(redis.call('keys','session:*')) do redis.call('del',k) end" 0
    # redis-cli KEYS "prefix:*" | tr "\n" "\0" | xargs -0 redis-cli DEL
  # end

  private
    def self.cache(redis, key, value)
      redis.set key, value
      value
    end

    def self.get_redis(opts)
      Redis.new(host: host || 'localhost', port: port || 6379, db: opts[:db] || default_db || 'simple-redis-cache')
    end

    def self.get_result(redis_result)
      begin eval redis_result rescue redis_result end
    end

end
