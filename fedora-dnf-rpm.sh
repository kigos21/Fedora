#!/bin/bash

# Configure dnf
echo "max_parallel_downloads=20" | tee -a /etc/dnf/dnf.conf
echo "defaultyes=True" | tee -a /etc/dnf/dnf.conf

# Update system
dnf clean all
dnf update -y

# Setup rpm repositories
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

dnf config-manager --enable fedora-cisco-openh264
dnf update @core -y

# Update again
dnf update -y

# Reboot
reboot

