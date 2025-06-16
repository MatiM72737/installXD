sudo pacman -Syu
sudo pacman -S base-devel git linux-headers nano --needed


git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

cd "$HOME"

paru -Syu

while IFS= read -r pkg; do
  [[ -z "$pkg" ]] && continue
  paru -S --noconfirm "$pkg"
done < dependencies.txt

sudo /opt/brother/Printers/dcpj105/cupswrapper/cupswrapperdcpj105

sudo systemctl enable cups
sudo systemctl start cups


sudo rm -rf /etc/default/cpupower
sudo wget -O /etc/default/cpupower https://raw.githubusercontent.com/MatiM72737/installXD/main/cpupower


sudo systemctl enable cpupower.service
sudo systemctl restart cpupower.service
