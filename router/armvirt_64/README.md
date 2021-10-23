# OpenWrt for Armvirt 64

Support vplus, beikeyun, l1pro, and Amlogic S9xxx STB are S905x3, S905x2, S922x, S905x, S905d, s905, s912. You can download the OpwnWrt firmware from [Releases](https://github.com/ophub/op/releases). Such as `openwrt_armvirt_${date}`.

This OpwnWrt firmware is packaged through [flippy-openwrt-actions](https://github.com/ophub/flippy-openwrt-actions) real-time call [openwrt_packit](https://github.com/unifreq/openwrt_packit) repository, and the OpwnWrt firmware completely adopts the default settings of `flippy`, He is the creator of OpenWrt for these boxes and opened up a new world for us to use OpenWrt in the series of boxes. Welcome to use `Fork` for personalized OpenWrt firmware configuration. If you like it, Please click the `Star`.

## OpenWrt Firmware instructions

| Model  | STB | [Optional kernel](https://github.com/ophub/flippy-kernel/tree/main/library) | OpenWrt Firmware |
| ---- | ---- | ---- | ---- |
| s922x | [Belink](https://tokopedia.link/RAgZmOM41db), [Belink-Pro](https://tokopedia.link/sfTHlfS41db), [Ugoos-AM6-Plus](https://tokopedia.link/pHGKXuV41db), [ODROID-N2](https://www.tokopedia.com/search?st=product&q=ODROID-N2) | All | openwrt_s922x_k*.img |
| s905x3 | [X96-Max+](https://tokopedia.link/uMaH09s41db), [HK1-Box](https://tokopedia.link/xhWeQgTuwfb), [H96-Max-X3](https://tokopedia.link/KuWvwoYuwfb), [Ugoos-X3](https://tokopedia.link/duoIXZpdGgb), [X96-Air](https://tokopedia.link/5WHiETbdGgb), [A95XF3-Air](https://tokopedia.link/ByBL45jdGgb) | All | openwrt_s905x3_k*.img |
| s905x2 | [X96Max-4G](https://tokopedia.link/HcfLaRzjqeb), [X96Max-2G](https://tokopedia.link/HcfLaRzjqeb) | All | openwrt_s905x2_k*.img |
| s912 | [H96-Pro-Plus](https://tokopedia.link/jb42fsBdGgb), Octopus-Planet | All | openwrt_s912_k*.img |
| s905d | Phicomm-N1 | All | openwrt_s905d_k*.img |
| s905x | [HG680P](https://tokopedia.link/HbrIbqQcGgb), [B860H](https://tokopedia.link/LC4DiTXtEib) | 5.4.* | openwrt_s905x_k*.img |
| s905w | [X96-Mini](https://tokopedia.link/ro207Hsjqeb), [TX3-Mini](https://www.tokopedia.com/beststereo/tanix-tx3-mini-2gb-16gb-android-7-1-kodi-17-3-amlogic-s905w-4k-tv-box) | 5.4.* | openwrt_s905w_k*.img |
| Allwinner H6 | V-Plus-Cloud | All | openwrt_h6_vplus_k*.img |
| Rockchip 3328 | BeikeYun, Chainedbox-L1-Pro | All | openwrt_rk3328_$soc_k*.img |

## Install to EMMC and update instructions

Choose the corresponding firmware according to your box. Then write the IMG file to the USB hard disk through software such as [Rufus](https://rufus.ie/) or [balenaEtcher](https://www.balena.io/etcher/). Insert the USB hard disk into the box. Common for all boxes.

- ### Install OpenWrt

Log in to the default IP: 192.168.1.1 → `Login in to openwrt` → `system menu` → `Amlogic Service` → `Install OpenWrt`

- ### Update OpenWrt

Log in to the default IP: 192.168.1.1 →  `Login in to openwrt` → `system menu` → `Amlogic Service` → `Update OpenWrt`

Tip: Functions such as install/update are provided by [luci-app-amlogic](https://github.com/ophub/luci-app-amlogic) to provide visual operation support. Also supports the use of script commands.

## Compilation method

- Select ***`Build OpenWrt for Armvirt`*** on the [Action](https://github.com/ophub/op/actions) page.
- Click the ***`Run workflow`*** button.

## Configuration file function description

| Folder/file name | Features |
| ---- | ---- |
| .config | Firmware related configuration, such as firmware kernel, file type, software package, luci-app, luci-theme, etc. |
| files | Create a files directory under the root directory of the warehouse and put the relevant files in. You can use custom files such as network/dhcp/wireless by default when compiling. |
| feeds.conf.default | Just put the feeds.conf.default file into the root directory of the warehouse, it will overwrite the relevant files in the OpenWrt source directory. |
| diy-part1.sh | Execute before updating and installing feeds, you can write instructions for modifying the source code into the script, such as adding/modifying/deleting feeds.conf.default. |
| diy-part2.sh | After updating and installing feeds, you can write the instructions for modifying the source code into the script, such as modifying the default IP, host name, theme, adding/removing software packages, etc. |

## .github/workflow/*.yml related environment variable description

| Environment variable | Features |
| ---- | ---- |
| REPO_URL | Source code warehouse address |
| REPO_BRANCH | Source branch |
| FEEDS_CONF | Custom feeds.conf.default file name |
| CONFIG_FILE | Custom .config file name |
| DIY_P1_SH | Custom diy-part1.sh file name |
| DIY_P2_SH | Custom diy-part2.sh file name |
| UPLOAD_BIN_DIR | Upload the bin directory (all ipk files and firmware). Default false |
| UPLOAD_FIRMWARE | Upload firmware catalog. Default true |
| UPLOAD_RELEASE | Upload firmware to release. Default true |
| RECENT_LASTEST | maximum retention days for release, artifacts and logs in GitHub Release and Actions. |
| TZ | Time zone setting |
| GITHUB_REPOSITORY | Github.com Environment variables. The owner and repository name. For example, ophub/op. |
| secrets.GITHUB_TOKEN | Personal center: Settings → Developer settings → Personal access tokens → Generate new token ( Name: GITHUB_TOKEN, Select: public_repo ). |

## Firmware compilation parameters

| Option | Value |
| ---- | ---- |
| Target System | QEMU ARM Virtual Machine |
| Subtarget | QEMU ARMv8 Virtual Machine(cortex-a53) |
| Target Profile | Default |
| Target Images | tar.gz |
| LuCI -> Applications | in the file: .config |

## Firmware information

| Name | Value |
| ---- | ---- |
| Default IP | 192.168.1.1 |
| Default username | root |
| Default password | password |
| Default WIFI name | OpenWrt |
| Default WIFI password | none |

