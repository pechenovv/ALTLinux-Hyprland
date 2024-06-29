#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Hyprland-Dots Packages #
# edit your packages desired here. 
# WARNING! If you remove packages here, dotfiles may not work properly.
# and also, ensure that packages are present in fedora repo or add copr repo

# add packages wanted here
Extra=(

)

# packages neeeded
hypr_package=( 
  curl
  gawk
  git
  grim
  gvfs
#i hope its not important
#  gvfs-mtp
  ImageMagick
  jq
  inxi
  kitty
  Kvantum
  nano
  NetworkManager-applet-gtk
  openssl
  pamixer
  pavucontrol
# pipewire pkg present all what are needed
#  pipewire-alsa
#  pipewire-utils
  pipewire
  playerctl
  polkit-gnome
  python3-module-requests
  python3-module-pip
  python3-module-pyquery
  qt5ct
  qt6ct
# not builded for alt
#  qt6-qtsvg
#rofi pkg in sisyphus provide wayland support
  rofi
  slurp
# maybe hyprshot can replace this
#  swappy
  hyprshot
# idk how to replace this
#  SwayNotificationCenter
  waybar
  wget2
  wl-clipboard
  wlogout
  xdg-user-dirs
  xdg-utils
  yad
)

# the following packages can be deleted. however, dotfiles may not work properly
hypr_package_2=(
  brightnessctl
  btop
  cava
  eog
  fastfetch
  gnome-system-monitor
  mousepad
  mpv
# i hope its not important
#  mpv-mpris
  nvtop
  qalculate-gtk
  vim-enhanced
)

#it will not work in alt
#copr_packages=(
# not builded
# aylurs-gtk-shell
# not builded. i think its important
#  cliphist
#  hypridle
# not builded
#  hyprlock
#  pamixer
#  pyprland
#  swww
)

# List of packages to uninstall as it conflicts with swaync or causing swaync to not function properly
uninstall=(
  dunst
  mako
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"


# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_hypr-pkgs.log"


# Installation of main components
printf "\n%s - Installing hyprland packages.... \n" "${NOTE}"

for PKG1 in "${hypr_package[@]}" "${hypr_package_2[@]}" "${copr_packages[@]}" "${Extra[@]}"; do
  install_package "$PKG1" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG1 Package installation failed, Please check the installation logs"
    exit 1
  fi
done

# removing dunst and mako to avoid swaync conflict
printf "\n%s - Checking if mako or dunst are installed and removing for swaync to work properly \n" "${NOTE}"

for PKG in "${uninstall[@]}"; do
  uninstall_package "$PKG" 2>&1 | tee -a "$LOG"
  if [ $? -ne 0 ]; then
    echo -e "\e[1A\e[K${ERROR} - $PKG uninstallation had failed, please check the log"
    exit 1
  fi
done

clear
