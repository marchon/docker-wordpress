#!/bin/bash

test -d /data/ || { echo "No data volume found. Skipping."; exit; }

# Grab wp-content if it's found (plugins etc)
if [ ! -d /data/app/ ]; then
  echo "Moving wp to blank volume.."
  cp -aR /app/ /data/app
fi

echo "Linking wp-content.."
rm -rf /app/
ln -sf /data/app /app/

# Grab custom config file if it's there
if [ -f /data/wp-content/wp-config-production.php ]; then
  echo "Using wp-config-production.php.."
  rm -f /app/wp-config.php
  ln -sf /data/app/wp-config/wp-config-production.php /app/wp-config.php
fi

# Grab .htaccess if it's there
#if [ -f /data/.htaccess ]; then
#  echo "Using .htaccess.."
#  ln -sf /data/.htaccess /app/.htaccess
#fi

# Execute init.sh if it's found
if [ -x /data/wp-content/init.sh ]; then
  echo "Executing custom init.sh.."
  /data/wp-content/init.sh
fi

