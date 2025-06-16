NEW_ARGS="nvidia-drm.modeset=1 nvidia-drm.fbdev=0 splash quiet vt.global_cursor_default=0 nvidia.NVreg_PreserveVideoMemoryAllocations=1 intel_iommu=on iommu=pt usbcore.autosuspend=-1 threadirqs mitigations=off idle=nomwait"
GRUB_FILE="/etc/default/grub"

# Ustaw wartości GRUB_TIMEOUT, GRUB_TIMEOUT_STYLE i GRUB_HIDDEN_TIMEOUT
sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' "$GRUB_FILE"
sudo sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=hidden/' "$GRUB_FILE"

# Dodaj GRUB_HIDDEN_TIMEOUT jeśli nie istnieje
if grep -q '^GRUB_HIDDEN_TIMEOUT=' "$GRUB_FILE"; then
    sudo sed -i 's/^GRUB_HIDDEN_TIMEOUT=.*/GRUB_HIDDEN_TIMEOUT=0/' "$GRUB_FILE"
else
    echo 'GRUB_HIDDEN_TIMEOUT=0' | sudo tee -a "$GRUB_FILE"
fi

# Modyfikuj GRUB_CMDLINE_LINUX_DEFAULT
if grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=' "$GRUB_FILE"; then
    for ARG in $NEW_ARGS; do
        sudo sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ {/ $ARG /! s/\"\$/ $ARG\"/}" "$GRUB_FILE"
    done
else
    echo "GRUB_CMDLINE_LINUX_DEFAULT=\"${NEW_ARGS}\"" | sudo tee -a "$GRUB_FILE"
fi

# Generowanie nowej konfiguracji GRUB-a
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
