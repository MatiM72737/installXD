SUDO_USER_NAME="$(logname)"
echo "$SUDO_USER_NAME ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/00-$SUDO_USER_NAME-nopasswd
sudo chmod 440 /etc/sudoers.d/00-$SUDO_USER_NAME-nopasswd

sudo pacman -Syu
sudo pacman -S base-devel git linux-headers nano --needed


git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

cd "$HOME"

paru -Syu

paru -S firefox oh-my-posh-bin libxcrypt-compat cpupower perl fuse2 aylurs-gtk-shell-git lib32-libcups meson vala valadoc gobject-introspection gtk-layer-shell libastal-git jq bibata-cursor-theme-bin ttf-meslo-nerd ttf-meslo-nerd-font-powerlevel10k socat qt6ct kvantum cups brother-dcpj105 swww btop imv vlc ventoy-bin pwvucontrol yabridge yabridgectl downgrade egl-wayland vesktop-bin ayugram-desktop-bin pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber nautilus-admin-gtk4 qpwgraph nautilus nautilus-empty-file nautilus-gnome-disks nautilus-mediainfo-gtk4 nwg-look ghostty code wget curl fish nvidia nvidia-utils lib32-nvidia-utils nvidia-settings gtk4 gtk3 ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite libxrender libxcursor pixman wayland-protocols cairo pango libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang-git hyprcursor-git hyprwayland-scanner-git xcb-util-errors hyprutils-git glaze hyprgraphics-git aquamarine-git re2 hyprland-qtutils aquamarine hyprpolkitagent qbittorrent wl-clip-persist wl-clipboard sweet-gtk-theme-dark sweet-folders-icons-git hyprlock hypridle hyprpicker obs-studio xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk stow fastfetch hyprsunset hyprlang hyprcursor hyprutils hyprgraphics hyprwayland-scanner

sudo /opt/brother/Printers/dcpj105/cupswrapper/cupswrapperdcpj105

sudo systemctl enable cups
sudo systemctl start cups


git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install

cd "$HOME"

git clone https://github.com/MatiM72737/.myHyprDots.git MyHyprDots
cd MyHyprDots
stow --adopt *
git restore .

cd "$HOME"

git clone https://github.com/michaelScopic/Wallpapers.git "$HOME/wallpapers"


#mkdir -p "$HOME/.cache/paru/clone/davinci-resolve-studio"
#wget --trust-server-names --content-disposition --no-check-certificate -O "$HOME/.cache/paru/clone/davinci-resolve-studio/DaVinci_Resolve_Studio_20.0_Linux.zip" "https://drive.usercontent.google.com/download?id=1XJH86ze0tHDGU5Z3kU6VVfxTukNaq0lP&export=download&authuser=0&confirm=t&uuid=ddc96146-94fc-441f-83af-426c0b7dc3fb&at=AN8xHooVxk-lxryw-mojyfjfGSXs%3A1749926599375"

#cd "$HOME"

paru -S davinci-resolve-studio
cd /opt/resolve/libs
sudo rm -rf disabled-libraries
sudo mkdir disabled-libraries && sudo mv libglib* libgio* libgmodule* disabled-libraries
sudo /usr/bin/perl -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' /opt/resolve/bin/resolve

sudo rm -rf /etc/default/cpupower
sudo wget -O /etc/default/cpupower https://raw.githubusercontent.com/MatiM72737/installXD/main/cpupower


sudo systemctl enable cpupower.service
sudo systemctl restart cpupower.service

sudo systemctl enable getty@tty1

sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo rm -rf /etc/systemd/system/getty@tty1.service.d/override.conf
sudo wget -O /etc/systemd/system/getty@tty1.service.d/override.conf https://raw.githubusercontent.com/MatiM72737/installXD/refs/heads/main/override.conf

chsh -s /usr/bin/fish
sudo chsh -s /usr/bin/fish

NEW_ARGS="nvidia-drm.modeset=1 nvidia-drm.fbdev=0 splash quiet vt.global_cursor_default=0 nvidia.NVreg_PreserveVideoMemoryAllocations=1 intel_iommu=on iommu=pt usbcore.autosuspend=-1 threadirqs mitigations=off idle=nomwait"

# Plik konfiguracyjny GRUB-a
GRUB_FILE="/etc/default/grub"

# Tylko jeśli linia istnieje i nie zawiera już tych argumentów
if grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=' "$GRUB_FILE"; then
    for ARG in $NEW_ARGS; do
        sudo sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ {/ $ARG /! s/\"\$/ $ARG\"/}" "$GRUB_FILE"
    done
else
    echo "GRUB_CMDLINE_LINUX_DEFAULT=\"${NEW_ARGS}\"" | sudo tee -a "$GRUB_FILE"
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg

MKINITCONF="/etc/mkinitcpio.conf"

# Sprawdź czy plik istnieje
if [[ ! -f "$MKINITCONF" ]]; then
    echo "Plik $MKINITCONF nie istnieje."
    exit 1
fi

# 1. Dodaj moduły NVIDIA na początek MODULES=()
sudo sed -i -E 's|^MODULES=\(\s*|MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm |' "$MKINITCONF"

# 2. Usuń 'kms' z HOOKS=()
sudo sed -i -E 's/\<kms\>//g' "$MKINITCONF"
# Posprzątaj podwójne spacje
sudo sed -i -E 's/  +/ /g' "$MKINITCONF"

sudo mkinitcpio -P

LIMITS_FILE="/etc/security/limits.conf"
RTPRIO_LINE="@audio           -       rtprio          98"
MEMLOCK_LINE="@audio           -       memlock         unlimited"

# Dodaj tylko jeśli linia jeszcze nie istnieje
grep -qxF "$RTPRIO_LINE" "$LIMITS_FILE" || echo "$RTPRIO_LINE" | sudo tee -a "$LIMITS_FILE"
grep -qxF "$MEMLOCK_LINE" "$LIMITS_FILE" || echo "$MEMLOCK_LINE" | sudo tee -a "$LIMITS_FILE"

"hyprpm update

hyprpm add https://github.com/shezdy/hyprsplit
hyprpm enable hyprsplit

hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm enable Hyprspace" >> "$HOME/plugins.sh"
chmod +x "$HOME/plugins.sh"

sudo rm -f /etc/sudoers.d/00-$SUDO_USER_NAME-nopasswd

Hyprland
