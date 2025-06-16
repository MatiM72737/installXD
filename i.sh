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

