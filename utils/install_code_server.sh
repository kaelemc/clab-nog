# Install code-server for each user
source ../vars.sh

# Install the template unit file
sudo tee /etc/systemd/system/code-server@.service > /dev/null <<'EOF'
[Unit]
Description=code-server for %i
After=network.target

[Service]
Type=simple
User=%i
WorkingDirectory=/home/%i
ExecStart=/usr/bin/code-server
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

for i in $(seq 1 $GROUP_COUNT);
do
  USER=$USER_PREFIX$i
  sudo -u $USER mkdir -p /home/$USER/.config/code-server
  # Add the config to the user homedir
  # - The code server will run on port 808x where x is the group number
  #   ie. group7 will have code-server on port 8087
  #
  # - The code server password = username. 
  #   ie. group7 password will be group7
  sudo tee /home/$USER/.config/code-server/config.yaml > /dev/null <<EOF
bind-addr: 0.0.0.0:808$i
auth: password
password: $USER
cert: false
EOF
  sudo chown -R $USER:$USER /home/$USER/.config
  sudo systemctl enable --now code-server@$USER
done
