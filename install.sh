sudo pacman -Syu
sudo pacman -S base-devel git linux-headers nano --needed


git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

cd ~

paru -Syu

paru -S firefox socat swww btop imv vlc ventoy pwvucontrol yabridge yabridge-ctl downgrade egl-wayland vesktop ayugram-desktop pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber nautilus-admin-gtk4 qpwgraph nautilus nautilus-empty-file nautilus-gnome-disks nautilus-mediainfo-gtk4 nwg-look ghostty code wget curl fish nvidia nvidia-utils lib32-nvidia-utils nvidia-settings gtk4 gtk3 aylurs-gtk-shell ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite libxrender libxcursor pixman wayland-protocols cairo pango libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang-git hyprcursor-git hyprwayland-scanner-git xcb-util-errors hyprutils-git glaze hyprgraphics-git aquamarine-git re2 hyprland-qtutils aquamarine hyprpolkitagent qbittorrent wl-clip-persist wl-clipboard sweet-gtk-theme-dark sweet-folders-icons-git hyprlock hypridle hyprpicker obs-studio xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk stow fastfetch hyprsunset hyprlang hyprcursor hyprutils hyprgraphics hyprwayland-scanner

git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install

cd ~

hyprpm update

hyprpm add https://github.com/shezdy/hyprsplit
hyprpm enable hyprsplit

hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm enable Hyprspace

git clone https://github.com/MatiM72737/.myHyprDots.git MyHyprDots
cd MyHyprDots
stow --adopt *
git restore .

cd ~

git clone https://github.com/michaelScopic/Wallpapers.git ~/wallpapers


mkdir -p ~\.cache\paru\clone\davinci-resolve-studio
cd ~\.cache\paru\clone\davinci-resolve-studio
wget -O DaVinci_Resolve_Studio_20.0_Linux.zip https://drive.usercontent.google.com/download?id=1XJH86ze0tHDGU5Z3kU6VVfxTukNaq0lP&export=download&authuser=0&confirm=t&uuid=ddc96146-94fc-441f-83af-426c0b7dc3fb&at=AN8xHooVxk-lxryw-mojyfjfGSXs%3A1749926599375

cd ~

paru -S libxcrypt-compat cpupower perl libcurl libcurl-devel mesa-libGLU fuse2 davinci-resolve-studio
cd /opt/resolve/libs
sudo rm -rf disabled-libraries
sudo mkdir disabled-libraries && sudo mv libglib* libgio* libgmodule* disabled-libraries
sudo /usr/bin/perl -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' /opt/resolve/bin/resolve
sudo rm -rf /etc/default/cpupower
sudo wget -O /etc/default/cpupower https://raw.githubusercontent.com/MatiM72737/installXD/main/cpupower


sudo systemctl enable cpupower.service
sudo systemctl restart cpupower.service

sudo systemctl enable getty@tty1

sudo mkdir -p /etc\systemd\system\getty@tty1.service.d
sudo rm -rf /etc\systemd\system\getty@tty1.service.d\override.conf
sudo wget -O /etc\systemd\system\getty@tty1.service.d\override.conf https://raw.githubusercontent.com/MatiM72737/installXD/refs/heads/main/override.conf

chsh -s /usr/bin/fish
sudo chsh -s /usr/bin/fish
