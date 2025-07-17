# One script should bootstrap the whole server -- assuming CentOS 9 for now

sudo dnf update -y

./install_clab.sh
./install_edgeshark.sh
./create_users.sh
./install_code_server.sh

