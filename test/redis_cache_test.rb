require 'test_helper'

class RedisCacheTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, RedisCache
  end
end
