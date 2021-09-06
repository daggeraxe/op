#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/op
# Description: Automatically Build OpenWrt for Raspberry Pi-4
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/coolsnowwolf/lede / Branch: master
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Modify some code adaptation
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

# for Raspberry Pi 4 wifi
sed -i 's/36/44/g;s/VHT80/VHT20/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default theme（FROM uci-theme-bootstrap CHANGE TO luci-theme-material）
sed -i 's/luci-theme-bootstrap/luci-theme-material/g' ./feeds/luci/collections/luci/Makefile

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
# sed -i 's/192.168.1.1/192.168.31.4/g' package/base-files/files/bin/config_generate

# Modify default root's password（FROM 'password'[$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.] CHANGE TO 'your password'）
# sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' /etc/shadow

# Set DISTRIB_REVISION
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/lean/default-settings/files/zzz-default-settings
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Mydiy-luci-app-and-theme（use to /.config luci-app&theme）
# ==========luci-app-url==========
# git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
# ==========luci-theme-url==========
# git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
# svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-theme-edge package/luci-theme-edge
#
# ------------------------------- Other ends -------------------------------

