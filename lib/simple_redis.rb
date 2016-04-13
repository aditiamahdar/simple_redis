require "redis"

module SimpleRedis
  class << self
    attr_accessor :host
    attr_accessor :port
    attr_accessor :default_db
    attr_accessor :current_opts
    attr_accessor :current_redis
  end

  def self.configuration
    yield self
  end

  def self.fetch(opts={})
    redis = get_redis(opts)
    result = redis.get opts[:key]
    get_result(result || cache(redis, opts[:key], block_given? ? yield : opts[:value]))
  end

  def self.set(key, value, opts={})
    redis = get_redis(opts)
    result = cache(redis, key, value)
    get_result(result)
  end

  def self.get(key, opts={})
    redis = get_redis(opts)
    result = redis.get key
    get_result(result)
  end

  def self.total_matches(key, opts={})
    redis = get_redis(opts)
    redis.keys(key).size
  end

  def self.delete_matched(key, opts={})
    redis = get_redis(opts)
    redis.del(*redis.keys(key)) rescue 0
  end

  # PRIVATE METHODS
    def self.cache(redis, key, value)
      redis.set key, normalize(value)
      value
    end

    def self.normalize(value)
      value.class.in?(NORMAL_DATA_TYPES) ? value : value.to_json
    end

    def self.get_result(redis_result)
      begin eval(redis_result) rescue redis_result end
    end

    def self.get_redis(opts={})
      current_opts.eql?(opts) ? current_redis : new_redis(opts)
    end

    def self.new_redis(opts={})
      current_opts = opts
      current_redis = Redis.new(host: get_host(opts), port: get_port(opts), db: get_db(opts))
    end

    def self.get_host(opts={})
      opts[:host] || host || HOST
    end

    def self.get_port(opts={})
      opts[:port] || port || PORT
    end

    def self.get_db(opts={})
      opts[:db] || default_db || DEFAULT_DB
    end
    private_class_method :cache, :normalize, :get_result, :get_redis, :new_redis,
      :get_host, :get_port, :get_db

end
