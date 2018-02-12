STARTING_DIR=`pwd`
wget https://wordpress.org/latest.tar.gz
cd /tmp
tar -xzvf latest.tar.gz
rm latest.tar.gz
sudo chown -R ec2-user:apache wordpress
cd $STARTING_DIR
