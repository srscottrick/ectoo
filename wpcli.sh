# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# mv wp-cli.phar ~/bin
# chmod u+x ~/bin/wp-cli.phar

# wp core install --url=example.com --title=Example --admin_user=supervisor --admin_email=info@example.com --prompt=admin_password


CURRENT_DIR=`pwd`
WP_TEMP_DIR=/tmp/wptemp

if [ -d "$WP_TEMP_DIR" ]; then
    rm -rf $WP_TEMP_DIR
fi

mkdir $WP_TEMP_DIR
cd $WP_TEMP_DIR

echo -n "Wordpress database name: "
read maria_db_name
echo -n "Wordpress database user: "
read maria_db_user
echo -n "Wordpress database password: "
read -s maria_db_password
echo

echo -n "Wordpress admin email: "
read wordpress_admin_email

echo -n "Wordpress admin user: "
read wordpress_admin_user

echo -n "Wordpress admin password: "
read -s wordpress_admin_password
echo

echo -n "Wordpress url: "
read wordpress_url

echo -n "Wordpress title: "
read wordpress_title

wp core download --path=$WP_TEMP_DIR
wp config create --dbname=$maria_db_name --dbuser=$maria_db_user --dbpass=$maria_db_password
wp core install --url=$wordpress_url --title="$wordpress_title" --admin_user=$wordpress_admin_user --admin_email=$wordpress_admin_email --prompt=admin_password

cd $CURRENT_DIR



