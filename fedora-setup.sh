#!/bin/bash

# NVIDIA
dnf update -y
dnf install akmod-nvidia -y
dnf install xorg-x11-drv-nvidia-cuda -y #cuda/nvdec/nvenc support
dnf install xorg-x11-drv-nvidia-cuda-libs -y # NVENC/NVDEC
dnf install nvidia-vaapi-driver libva-utils vdpauinfo -y # VDPAU/VAAPI

# Multimedia
dnf swap ffmpeg-free ffmpeg --allowerasing -y # Full ffmpeg
# Additional codecs
dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
# Sound and video
dnf update @sound-and-video -y
# Hardware codecs with NVIDIA
dnf install libva-nvidia-driver -y

# Setup flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Reboot
echo '-----------------------------------------------------------'
echo 'REBOOT AFTER: "modinfo -F version nvidia" should outputs the version of the driver such as 440.64 and not modinfo: ERROR: Module nvidia not found.'
echo '-----------------------------------------------------------'