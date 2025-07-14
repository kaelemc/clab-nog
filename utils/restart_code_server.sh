# Restart code-server for all users
source ../vars.sh

# incase we edit the systemd unit file
sudo systemctl daemon-reload

for i in $(seq 1 $GROUP_COUNT);
do
  sudo systemctl restart code-server@$USER_PREFIX$i
done
