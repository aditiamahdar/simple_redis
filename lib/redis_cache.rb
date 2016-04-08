module RedisCache
  # Set or Get cache from Redis, opts => db, key, value, block
  def self.fetch(opts={})
    if block_given?
      # Use yield to set the data
    else
      # Use opts[:value] to set the data
    end
  end
end
