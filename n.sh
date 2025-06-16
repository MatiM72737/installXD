cd "$HOME"

git clone https://github.com/MatiM72737/.myHyprDots.git MyHyprDots
cd MyHyprDots
stow --adopt *
git restore .

cd "$HOME"

git clone https://github.com/michaelScopic/Wallpapers.git "$HOME/wallpapers"

sudo /opt/brother/Printers/dcpj105/cupswrapper/cupswrapperdcpj105

sudo systemctl enable cups
sudo systemctl start cups

sudo rm -rf /etc/default/cpupower
sudo wget -O /etc/default/cpupower https://raw.githubusercontent.com/MatiM72737/installXD/main/cpupower


sudo systemctl enable cpupower.service
sudo systemctl restart cpupower.service

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
