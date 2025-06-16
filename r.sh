
paru -S davinci-resolve-studio
#mkdir -p "$HOME/.cache/paru/clone/davinci-resolve-studio"
wget --trust-server-names --no-check-certificate -O "$HOME/.cache/paru/clone/davinci-resolve-studio/DaVinci_Resolve_Studio_20.0_Linux.zip" "http://192.168.136.155:1234/Download%2FDaVinci_Resolve_Studio_20.0_Linux-1.zip?forcedownload"

#cd "$HOME"

paru -S davinci-resolve-studio
cd /opt/resolve/libs
sudo rm -rf disabled-libraries
sudo mkdir /opt/resolve/libs/disabled-libraries && sudo mv libglib* libgio* libgmodule* /opt/resolve/libs/disabled-libraries
sudo /usr/bin/perl -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' /opt/resolve/bin/resolve
