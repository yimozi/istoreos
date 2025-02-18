#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的 192.168.10.1 修改成你想要的就可以了
#sed -i 's/192.168.100.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/OpenWrt/iStore OS/g' package/base-files/files/bin/config_generate

# ttyd 自动登录
# sed -i "s?/bin/login?/usr/libexec/login.sh?g" ${GITHUB_WORKSPACE}/openwrt/package/feeds/packages/ttyd/files/ttyd.config

# 添加自定义软件包
# echo '
# CONFIG_PACKAGE_luci-app-mosdns=y
# CONFIG_PACKAGE_luci-app-adguardhome=y
# CONFIG_PACKAGE_luci-app-openclash=y
# ' >> .config
# 移除无用第三方软件包
rm -rf feeds/third_party/luci-app-LingTiGameAcc

# 移除 bootstrap 主题，取消bootstrap为默认主题，修改argon为默认主题
sed -i 's/CONFIG_PACKAGE_luci-theme-bootstrap=y/CONFIG_PACKAGE_luci-theme-bootstrap=n/' .config
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' \
feeds/luci/collections/luci-ssl-openssl/Makefile \
feeds/luci/collections/luci-nginx/Makefile \
feeds/luci/collections/luci-light/Makefile

# 修改openwrt登陆地址,把下面的 10.0.0.1 修改成你想要的就可以了
# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/192.168.1.1/192.168.2.6/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/GateWay/g' package/base-files/files/bin/config_generate

# 修改root密码，清空登陆时显示的用户名
sed -i 's|root:::0:99999:7:::|root:\$1\$ULcYq3En\$Hm81ktg4DWEWO7UgSh8Kf.:19975:0:99999:7:::|' package/base-files/files/etc/shadow
sed -i 's/value="<%=duser%>"/value=""/' /root/openwrt/feeds/third/luci-theme-argon/luasrc/view/themes/argon/sysauth.htm
sed -i "s/let scope = { duser: 'root', fuser: user };/let scope = { duser: '', fuser: user };/g" feeds/luci/modules/luci-base/ucode/dispatcher.uc

# 将istoreos默认用户数据空间大小由2048M为128M
sed -i 's/2048/128/g' scripts/gen_image_generic.sh

# 更新 feeds，安装feeds
./scripts/feeds update -a && ./scripts/feeds install -a
