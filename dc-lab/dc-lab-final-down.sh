source ../vars.sh

LAB_SUBDIR="dc-lab"

for i in $(seq 1 $GROUP_COUNT);
do
    USERNAME=$USER_PREFIX$i
    sudo -u $USERNAME -H bash -c "source ~/.bashrc; clab des -c -t ~/$REPO_DIR/$LAB_SUBDIR/*final.clab.yml"
done
