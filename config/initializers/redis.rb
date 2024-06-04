require 'redis'

redis_config = { host: 'localhost', port: 6379 }

if Rails.env.production?
  # Use environment variables or Rails secrets for production configuration
else
  # Use development configuration (optional)
  redis_config.merge!({ database: 0 })  # Select database 0 (optional)
end

REDIS = Redis.new(redis_config)