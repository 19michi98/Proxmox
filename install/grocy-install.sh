#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   ____ __________  _______  __
  / __  / ___/ __ \/ ___/ / / /
 / /_/ / /  / /_/ / /__/ /_/ / 
 \__, /_/   \____/\___/\__, /  
/____/                /____/   
 
EOF
}
header_info
echo -e "Loading..."
APP="grocy"
var_disk="2"
var_cpu="1"
var_ram="512"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function install_grocy() {
  header_info
  msg_info "Downloading and installing ${APP} 4.1.0"
  wget https://github.com/grocy/grocy/releases/download/v4.1.0/grocy_4.1.0.zip -O grocy.zip
  unzip grocy.zip -d /var/www/html/grocy
  chown -R www-data:www-data /var/www/html/grocy
  rm grocy.zip
  msg_ok "${APP} installed"
}

function start() {
  default_settings
  build_container
  install_grocy
  description
  msg_ok "Completed Successfully!\n"
  echo -e "${APP} should be reachable by going to the following URL.\n${BL}http://${IP}${CL} \n"
}

start
