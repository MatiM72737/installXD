SUDO_USER_NAME="$(logname)"
echo "$SUDO_USER_NAME ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/00-$SUDO_USER_NAME-nopasswd
sudo chmod 440 /etc/sudoers.d/00-$SUDO_USER_NAME-nopasswd

bash ./i.sh

bash ./n.sh

bash ./h.sh

bash ./r.sh

bash ./a.sh

sudo rm -f /etc/sudoers.d/00-$SUDO_USER_NAME-nopasswd

chsh -s /usr/bin/fish
sudo chsh -s /usr/bin/fish

echo "OKKKKK"
