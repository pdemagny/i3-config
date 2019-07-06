#!/usr/bin/env bash
if [[ "$EUID" -ne 0 ]]; then echo "this installer should be run as root or with sudo privileges, exiting." && exit 1; fi

apt-get install -y i3 i3-wm i3lock i3status lightdm playerctl

for i in scripts/*; do
  bn=$(basename ${i})
  cp -v ${i} /usr/local/bin/ && chmod 755 /usr/local/bin/${bn} && chown root:root /usr/local/bin/${bn}
done

cp -v debian_10.png ~/.Images/

if [[ -e ~/.config/i3/config ]]; then mv ~/.config/i3/config ~/.config/i3/config.bak; fi
cp -v configs/config /etc/i3/config && chown root:root /etc/i3/config
cp -v configs/i3status.conf /etc/i3status.conf && chown root:root /etc/i3status.conf

wget -O /usr/local/bin/i3-style https://github.com/acrisci/i3-style/releases/download/v1.0.2/i3-style.x86_64 \
  && chmod -v +x /usr/local/bin/i3-style
i3-style archlinux -o /etc/i3/config --reload

i3-msg restart
