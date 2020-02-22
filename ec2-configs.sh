#sudo certbot certonly -n --standalone --email example@gmail.com --agree-tos --no-eff-email --preferred-challenges http -d example.com

#!/usr/bin/sh

increase_history_size() {
    THIS_HISTORY_SIZE=$1
    echo "HISTSIZE=${THIS_HISTORY_SIZE}" >> ~/.bashrc
    echo "HISTFILESIZE=${THIS_HISTORY_SIZE}" >> ~/.bashrc
}

create_swap_file() {
    SWAP_BS=$1
    SWAP_COUNT=$2
    SWAP_FILE_NAME=$3

    sudo dd if=/dev/zero of=${SWAP_FILE_NAME} bs=${SWAP_BS} count=${SWAP_COUNT}
    sudo chmod 600 ${SWAP_FILE_NAME}
    sudo mkswap ${SWAP_FILE_NAME}
    sudo swapon ${SWAP_FILE_NAME}
    echo "${SWAP_FILE_NAME} swap swap defaults 0 0" > /tmp/fstab3925
    sudo sh -c 'cat /tmp/fstab3925 >> /etc/fstab'
    rm /tmp/fstab3925
}

update_yum_packages() {
    sudo yum update -y
}

install_letsencrypt() {
    cd /tmp
    wget -O epel.rpm -nv \
         https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum install -y ./epel.rpm
    sudo yum install -y python2-certbot-apache.noarch
}

install_lamp() {
    sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
    sudo yum install -y httpd mariadb-server
}

configure_apache_user_and_dirs() {
    sudo chown -R ec2-user:apache /var/www
    sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
    find /var/www -type f -exec sudo chmod 0664 {} \;
}

enable_lamp_on_boot() {
  sudo systemctl enable httpd
  sudo systemctl enable mariadb

}

HISTORY_SIZE=50000
increase_history_size $HISTORY_SIZE
source ~/.bashrc

SWAP_FILE=/var/swapfile.1
SWAP_BYTE_SIZE=1024
SWAP_COUNT_SIZE_1G=1024000
SWAP_COUNT_SIZE_2G=2048000

create_swap_file $SWAP_BYTE_SIZE $SWAP_COUNT_SIZE_2G $SWAP_FILE
sudo swapon -s

update_yum_packages

install_letsencrypt
install_lamp
configure_apache_user_and_dirs
enable_lamp_on_boot

sudo systemctl is-enabled httpd
sudo systemctl is-enabled mariadb
sudo usermod -a -G apache ec2-user
