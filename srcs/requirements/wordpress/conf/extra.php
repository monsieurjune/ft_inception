define('WP_REDIS_HOST', 'redis');
define('WP_REDIS_PORT', 6379);
define('WP_REDIS_PASSWORD', getenv('REDIS_PASSWORD') ?: null);
define('WP_REDIS_DATABASE', 0);
define('WP_CACHE', true);
