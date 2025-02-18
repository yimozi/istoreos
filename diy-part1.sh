#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# echo 'src-git openclash https://github.com/vernesong/OpenClash' >>feeds.conf.default
# echo 'src-git adguardhome https://github.com/rufengsuixing/luci-app-adguardhome' >>feeds.conf.default
# echo 'src-git mosdns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
# 更新最新OpenClash源码
# 更新openclash内核
git clone --single-branch --depth 1 -b dev https://github.com/vernesong/OpenClash.git package/zhyoi/luci-app-openclash
wget https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz --no-check-certificate
mkdir -p files/etc/openclash/core/
tar -zxvf clash-linux-amd64.tar.gz  -C files/etc/openclash/core/
mv files/etc/openclash/core/clash files/etc/openclash/core/clash_meta
rm -rf clash-linux-amd64.tar.gz
curl -sL --connect-timeout 5 -m 30 --speed-time 15 --speed-limit 1 --retry 2 https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat -o files/etc/openclash/geoip.dat
curl -sL --connect-timeout 5 -m 30 --speed-time 15 --speed-limit 1 --retry 2 https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat -o files/etc/openclash/GeoSite.dat
curl -sL --connect-timeout 5 -m 30 --speed-time 15 --speed-limit 1 --retry 2  https://raw.githubusercontent.com/Loyalsoldier/geoip/release/Country.mmdb -o files/etc/openclash/Country.mmdb
