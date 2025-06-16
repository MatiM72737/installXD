git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install

cd "$HOME"

git clone https://github.com/MatiM72737/.myHyprDots.git MyHyprDots
cd MyHyprDots
stow --adopt *
git restore .

wget -O "$HOME/plugins.sh" "https://raw.githubusercontent.com/MatiM72737/installXD/refs/heads/main/plugins.sh"
chmod +x "$HOME/plugins.sh"

cd "$HOME"

git clone https://github.com/michaelScopic/Wallpapers.git "$HOME/wallpapers"
cd "$HOME"
sudo systemctl enable getty@tty1

sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo rm -rf /etc/systemd/system/getty@tty1.service.d/override.conf
sudo wget -O /etc/systemd/system/getty@tty1.service.d/override.conf https://raw.githubusercontent.com/MatiM72737/installXD/refs/heads/main/override.conf
