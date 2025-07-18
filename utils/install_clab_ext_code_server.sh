source ../vars.sh

EXTENSION="srl-labs.vscode-containerlab"

for i in $(seq 1 $GROUP_COUNT);
do
  # install the extension
  USER="$USER_PREFIX$i"
  HOME_DIR="/home/$USER"
  sudo -u "$USER" code-server --install-extension "$EXTENSION" --user-data-dir "$HOME_DIR/.local/share/code-server"--extensions-dir "$HOME_DIR/.local/share/code-server/extensions"

  # augment the settings for edgeshark capture
  SETTINGS_PATH="/home/$USER/.local/share/code-server/User/settings.json"

  # Ensure settings.json exists
  if ! sudo test -f "$SETTINGS_PATH"; then
    echo '{}' | sudo tee "$SETTINGS_PATH" > /dev/null
    sudo chown "$USER:$USER" "$SETTINGS_PATH"
  fi

  # Add or update the setting using jq
  sudo -u "$USER" jq '. + {"containerlab.remote.hostname": "srv.topologies.dev"}' "$SETTINGS_PATH" > "/tmp/settings-$USER.json"

  sudo mv "/tmp/settings-$USER.json" "$SETTINGS_PATH"
  sudo chown "$USER:$USER" "$SETTINGS_PATH"
done
