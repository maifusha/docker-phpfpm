#!/bin/bash

set -eo pipefail

if [ -d "./scripts" ]
then
    for script in ./scripts/*; do
        echo "running $script"; "$script";
    done
fi

export APP_ENV=${APP_ENV:-production}
cd /usr/local/etc/php && ln -sf php.ini-${APP_ENV} php.ini && cd - > /dev/null

if [ "$1" = 'php-fpm' ]; then
	exec php-fpm
fi

exec "$@"
