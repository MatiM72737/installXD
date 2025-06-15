git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install

cd "$HOME"

sudo systemctl enable getty@tty1

sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo rm -rf /etc/systemd/system/getty@tty1.service.d/override.conf
sudo wget -O /etc/systemd/system/getty@tty1.service.d/override.conf https://raw.githubusercontent.com/MatiM72737/installXD/refs/heads/main/override.conf