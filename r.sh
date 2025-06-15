paru -S davinci-resolve-studio
cd /opt/resolve/libs
sudo rm -rf disabled-libraries
sudo mkdir disabled-libraries && sudo mv libglib* libgio* libgmodule* disabled-libraries
sudo /usr/bin/perl -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' /opt/resolve/bin/resolve