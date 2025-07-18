source vars.sh

for i in $(seq 1 $GROUP_COUNT);
do
    USERNAME=$USER_PREFIX$i
    # rm -rf /home/$USERNAME/$REPO_DIR
    sudo -u $USERNAME -H bash -c "cd ~; git clone $REPO_URL" 
done