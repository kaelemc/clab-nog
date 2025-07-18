# Create all the users
source ../vars.sh

for i in $(seq 1 $GROUP_COUNT);
do
  USER=$USER_PREFIX$i
  sudo useradd -m -s /bin/bash $USER
  echo "$USER:$USER" | sudo chpasswd
  # Set GROUP_ID on login
  sudo bash -c "echo 'export GROUP_ID=$i' >> /home/$USER/.bashrc"
  sudo chown $USER:$USER /home/$USER/.bashrc
  # Add user to relevant groups to allow clab execution
  sudo usermod -aG clab_admins $USER
  sudo usermod -aG docker $USER
done
