source vars.sh

for i in $(seq 1 $GROUP_COUNT);
do
    USERNAME=$USER_PREFIX$i
    sudo -u $USERNAME -H bash -c "source ~/.bashrc; clab des -c -a"
done
