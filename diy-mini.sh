#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 修改默认IP
# sed -i 's/192.168.1.1/10.10.10.10/g' package/base-files/files/bin/config_generate

# Autocore
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Cpufreq
sed -i 's/services/system/g' feeds/luci/applications/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# 移除重复软件包
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-wrtbwmon
rm -rf feeds/luci/applications/luci-app-dockerman

# 添加额外软件包
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
svn co https://github.com/kiddin9/openwrt-bypass/trunk/luci-app-bypass package/luci-app-bypass
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/luci-app-smartdns

# 科学上网插件
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
svn co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd

# 科学上网插件依赖
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/chinadns-ng
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2tcp package/dns2tcp
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/microsocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/naiveproxy
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/pdnsd-alt
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/sagernet-core package/sagernet-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/trojan-plus
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-geodata package/v2ray-geodata
svn co https://github.com/fw876/helloworld/trunk/simple-obfs package/simple-obfs
svn co https://github.com/fw876/helloworld/trunk/v2ray-core package/v2ray-core
svn co https://github.com/fw876/helloworld/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/shadowsocks-rust
svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/shadowsocksr-libev
svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core
svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/xray-plugin
svn co https://github.com/fw876/helloworld/trunk/lua-neturl package/lua-neturl
svn co https://github.com/fw876/helloworld/trunk/trojan package/trojan

# Themes
git clone -b 18.06 https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
svn co https://github.com/haiibo/packages/trunk/luci-theme-opentomcat package/luci-theme-opentomcat
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone https://github.com/thinktip/luci-theme-neobird package/luci-theme-neobird

# 晶晨宝盒
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
sed -i "s|https.*/OpenWrt|https://github.com/haiibo/OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/ophub/kernel/tree/main/pub/stable|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|ARMv8_MINI|g" package/luci-app-amlogic/root/etc/config/amlogic

# 流量监控
svn co https://github.com/haiibo/packages/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/haiibo/packages/trunk/wrtbwmon package/wrtbwmon

# 在线用户
git clone https://github.com/haiibo/luci-app-onliner.git package/luci-app-onliner
sed -i '/bin\/sh/a\uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '/nlbwmon/a\uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings

# 修改版本为编译日期
date_version=$(date +"%Y.%m.%d")
orig_version=$(echo "$(cat package/lean/default-settings/files/zzz-default-settings)" | grep -Po "DISTRIB_REVISION=\'\K[^\']*")
sed -i "s/${orig_version}/R${date_version}/g" package/lean/default-settings/files/zzz-default-settings

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/lang\/golang\/golang\-package\.mk/include \$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang\-package\.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHREPO/PKG_SOURCE_URL:=https:\/\/github\.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=\@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload\.github\.com/g' {}

# 调整 Dockerman 到 服务 菜单
sed -i '13s/"config"/"overview"/g' package/luci-app-dockerman/luasrc/controller/*.lua
sed -i 's/"admin"/"admin", "services"/g' package/luci-app-dockerman/luasrc/controller/*.lua
sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/model/*.lua
sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/view/dockerman/*.htm
sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm

# 修改插件名字
sed -i 's/"带宽监控"/"监控"/g' `grep "带宽监控" -rl ./`

./scripts/feeds update -a
./scripts/feeds install -a
