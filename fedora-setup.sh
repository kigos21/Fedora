#!/bin/bash

# Configure dnf
echo "max_parallel_downloads=20" | tee -a /etc/dnf/dnf.conf
echo "defaultyes=True" | tee -a /etc/dnf/dnf.conf

# Update system
dnf clean all
dnf update -y

# Setup rpm repositories
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y

dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

dnf group update core -y
dnf groupupdate core -y

# Install NVIDIA drivers
dnf update -y
dnf install akmod-nvidia -y
dnf install xorg-x11-drv-nvidia-cuda -y

# Install codecs/multimedia
dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
dnf install lame\* --exclude=lame-devel -y
dnf group upgrade --with-optional Multimedia -y

dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
dnf groupupdate sound-and-video -y

dnf install nvidia-vaapi-driver -y

dnf swap ffmpeg-free ffmpeg --allowerasing

# Setup flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Reboot
reboot
