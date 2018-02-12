# Create wp-config.php with salts

wp_create_config_file() {

    database_name_here="MYDB"
    username_here="MYUSER"
    password_here="MYPASS"
    echo "<?php"
    echo "define('DB_NAME', '$database_name_here');"
    echo "define('DB_USER', '$username_here');"
    echo "define('DB_PASSWORD', '$password_here');"
    echo "define('DB_HOST', 'localhost');"
    echo "define('DB_CHARSET', 'utf8');"
    echo "define('DB_COLLATE', '');"
    cat $TMP_SALTS_FILE
    echo $salts
    echo "\$table_prefix  = 'wp_';"
    echo "define('WP_DEBUG', false);"
    echo "define( 'WP_ALLOW_MULTISITE', true );"

    echo "if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');"
    echo "require_once(ABSPATH . 'wp-settings.php');"
}

wp_create_config_file_setup () {
    TMP_SALTS_FILE=/tmp/salts.txt
    TMP_WP_CONFIG_FILE=/tmp/wp-config.php

    wget -O $WP_SALTS_FILE https://api.wordpress.org/secret-key/1.1/salt/
    wp_create_config_file > $TMP_WP_CONFIG_FILE
    rm $TMP_SALTS_FILE
}
