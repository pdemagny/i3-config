#!/usr/bin/env bash
if [[ "$EUID" -ne 0 ]]; then echo "this installer should be run as root or with sudo privileges, exiting." && exit 1; fi

apt-get install -y i3 i3-wm i3lock i3status lightdm nitrogen xautolock playerctl

for i in scripts/*; do
  bn=$(basename ${i})
  cp -v ${i} /usr/local/bin/ && chmod 755 /usr/local/bin/${bn} && chown root:root /usr/local/bin/${bn}
done

cp -v configs/config /etc/i3/config && chown root:root /etc/i3/config
cp -v configs/i3status.conf /etc/i3status.conf && chown root:root /etc/i3status.conf

i3-msg restart
