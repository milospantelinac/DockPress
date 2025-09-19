docker run --rm -v dock-press_wp_core:/dest \
  wordpress:6.8.2-php8.2-fpm \
  bash -lc 'shopt -s dotglob; cp -r /usr/src/wordpress/* /dest/ && chown -R www-data:www-data /dest/'