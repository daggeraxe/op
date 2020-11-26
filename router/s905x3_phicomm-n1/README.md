# OpenWrt for S905x3-Boxs and Phicomm-N1

You can download the OpwnWrt for S905x3-Boxs and Phicomm-N1 firmware from [Releases](https://github.com/ophub/op/releases). Such as `openwrt_s905x3_phicomm-n1_${date}`. Then write the IMG file to the USB hard disk through software such as [balenaEtcher](https://www.balena.io/etcher/).

## Firmware instructions

- `n1-v*-openwrt_*.img`: For Phicomm-N1.
- `x96-v*-openwrt_*.img`: Almost compatible with all S905x3-Boxs, you can choose different box types when installing into EMMC.
- `hk1-v*-openwrt_*.img`: For HK1-Box(S905x3).
- `h96-v*-openwrt_*.img`: For H96-Max-X3(S905x3).
- `octopus-v*-openwrt_*.img` For Octopus-Planet.

## Install to Phicomm-N1 emmc partition and upgrade instructions

The `n1-v*-openwrt_*.img` firmware supports USB hard disk booting. You can also Install the OpenWrt firmware in the USB hard disk into the EMMC partition of Phicomm N1, and start using it from EMMC.

***`Install OpenWrt`***

Insert the ***`USB hard disk`*** with the written openwrt firmware into the Phicomm N1, and then plug it into the ***`power supply`***. The Phicomm N1 will automatically start the openwrt system from the USB hard disk, wait for about 2 minutes, select ***`OpenWrt`*** in the wireless wifi list of your computer, no password, the computer will automatically obtain the IP, Enter OpwnWrt's IP Address: ***`192.168.1.1`***, Account: ***`root`***, Password: ***`password`***, and then log in OpenWrt system.

- Log in to the default IP: 192.168.1.1 → `Login in to openwrt` → `system menu` → `TTYD terminal` → input command: 
```shell script
n1-install.sh
reboot
```
Wait for the installation to complete. remove the USB hard disk, unplug/plug in the power again, reboot into EMMC.


***`Upgrading OpenWrt`***

Write the new version of the openwrt system to the USB hard drive. ***`Insert the USB hard disk`*** of the openwrt system into the USB port of phicomm-n1 near HDMI. Plug in the power source, the openwrt system in the USB hard disk will be started. Enter OpwnWrt's IP Address: ***`192.168.1.1`***, Account: ***`root`***, Password: ***`password`***, and then log in OpenWrt system, run the upgrade command, and use the system in the USB hard disk to upgrade the system in the EMMC partition in the phicomm-n1 box.

- Log in to the default IP: 192.168.1.1 → `Login in to openwrt` → `system menu` → `TTYD terminal` → input command: 
```shell script
n1-update.sh
reboot
```

If the partition fails and cannot be written, you can restore the bootloader, restart it, and run the relevant command again.
```shell script
dd if=/root/u-boot-2015-phicomm-n1.bin of=/dev/mmcblk1
sync
reboot
```

## Install to S905x3-Boxs emmc partition and upgrade instructions

The `x96-v*-openwrt_*.img` and related s905x3 kernel firmware supports USB hard disk booting. You can also Install the OpenWrt firmware in the USB hard disk into the EMMC partition of S905x3, and start using it from EMMC.

- Open the developer mode: Settings → About this machine → Version number (for example: X96max plus...), click on the version number for 7 times in quick succession, and you will see that the developer mode is turned on.

- Turn on USB debugging: After restarting, enter Settings → System → Advanced options → Developer options again (after entering, confirm that the status is on, and the USB debugging status in the list is also on)

- Boot from USB hard disk: Unplug the power → insert the USB hard disk → insert the thimble into the AV port (top reset button) → insert the power → release the thimble of the av port → the system will boot from the USB hard disk.

- Log in to the system: Connect the computer and the s905x3 box with a network interface → turn off the wireless wifi on the computer → enable the wired connection → manually set the computer ip to the same network segment ip as openwrt, ipaddr such as ***`192.168.1.2`***. The netmask is ***`255.255.255.0`***, and others are not filled in. You can log in to the openwrt system from the browser, Enter OpwnWrt's IP Address: ***`192.168.1.1`***, Account: ***`root`***, Password: ***`password`***, and then log in OpenWrt system.

- Tips: When booting from USB hard disk, the network card is 100M, and it will automatically become Gigabit after writing into EMMC.

- Install OpenWrt: `Login in to openwrt` → `system menu` → `TTYD terminal` → input command: 
```shell script
s905x3-install.sh
reboot
```

Install Recommended practice: After writing the emmc partition from the USB hard disk, ***`first plug in the original USB hard disk and restart it`*** by unplugging/plugging in the power source until the boot is completed and the default IP: 192.168.1.1 can be accessed. Then unplug the USB hard drive, and officially boot from the emmc partition by unplugging/plugging in the power source.


Upgrading OpenWrt: `Login in to openwrt` → `system menu` → `file transfer` → upload ***`s905x3-openwrt.img.gz`*** to ***`/tmp/upload/`***, enter the `system menu` → `TTYD terminal` → input command: 
```shell script
mv -f /tmp/upload/*.img.gz /mnt/mmcblk2p4/
cp -f /usr/bin/s905x3-update.sh /mnt/mmcblk2p4/
cd /mnt/mmcblk2p4/
gzip -df *.img.gz
s905x3-update.sh
#s905x3-update.sh  your_openwrt_imgFileName.img
reboot
```

Tips: If there is only one `.img` file in the ***`/mnt/mmcblk2p4/`*** directory, you can just enter the ***`s905x3-update.sh`*** command without specifying a specific file name. The upgrade script will vaguely look for `.img` files from the fixed directory and try to upgrade. If there are multiple `.img` files in the ***`/mnt/mmcblk2p4/`*** directory, please use the ***`s905x3-update.sh your_openwrt_imgFileName.img`*** command to specify the firmware upgrade.

Upgrade Recommended method: After the upgrade is completed, if the system cannot be started, ***`you can plug in the USB hard disk with the openwrt system to boot once`***, until you can access the default IP of the firmware on the USB hard disk. Then unplug the USB hard drive, and officially boot from the emmc partition by unplugging/plugging in the power source.


Write bootloader: If your box is X96-Max+, you must write the bootloader of HK1-Box included in the firmware to EMMC before it can be gigabit. This step is now integrated into the installation script and is automatically completed during installation:

```shell script
dd if=/root/hk1box-bootloader.img  of=/dev/mmcblk2 bs=1 count=442 conv=fsync 2>/dev/null
dd if=/root/hk1box-bootloader.img  of=/dev/mmcblk2 bs=512 skip=1 seek=1 conv=fsync 2>/dev/null
sync
reboot
```
## Bypass gateway settings

If used as a bypass gateway, you can add custom firewall rules as needed (Network → Firewall → Custom Rules):
```shell script
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE        #If the interface is eth0.
iptables -t nat -I POSTROUTING -o br-lan -j MASQUERADE      #If the interface is br-lan bridged.
```

## Option description when installing into s905x3-boxs emmc

You can refer to the [dtb library](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1/armbian/dtb-amlogic) when you customize the file name.

| Serial | Box | Description | DTB |
| ---- | ---- | ---- | ---- |
| 1 | X96-Max+ | S905x3: NETWORK: 1000M / TF: 30Mtz / CPU: 2124Mtz | meson-sm1-x96-max-plus.dtb |
| 2 | HK1-Box | S905x3: NETWORK: 1000M / TF: 25Mtz / CPU: 2124Mtz | meson-sm1-hk1box-vontar-x3.dtb |
| 3 | H96-Max-X3 | S905x3: NETWORK: 1000M / TF: 50Mtz / CPU: 2124Mtz | meson-sm1-h96-max-x3.dtb |
| 4 | X96-Max-4G | S905x2: NETWORK: 1000M / TF: 50Mtz / CPU: 1944Mtz | meson-g12a-x96-max.dtb |
| 5 | X96-Max-2G | S905x2: NETWORK: 100M  / TF: 50Mtz / CPU: 1944Mtz | meson-g12a-x96-max-rmii.dtb |
| 6 | X96-Max+ | 905x3: NETWORK: 1000M / TF: 30Mtz / CPU: 2244Mtz | meson-sm1-x96-max-plus-oc.dtb |
| 7 | HK1-Box | S905x3: NETWORK: 1000M / TF: 25Mtz / CPU: 2184Mtz | meson-sm1-hk1box-vontar-x3-oc.dtb |
| 8 | H96-Max-X3 | S905x3: NETWORK: 1000M / TF: 50Mtz / CPU: 2208Mtz | meson-sm1-h96-max-x3-oc.dtb |
| 9 | Octopus-Planet | S905x3: NETWORK: 1000M / TF: 30Mtz / CPU: 2124Mtz | meson-gxm-octopus-planet.dtb |
| 0 | Other | - | Enter the dtb file name |

## Bypass gateway settings

Note: If used as a bypass gateway, you can add custom firewall rules as needed (Network → Firewall → Custom Rules):
```shell script
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE        #If the interface is eth0.
iptables -t nat -I POSTROUTING -o br-lan -j MASQUERADE      #If the interface is br-lan bridged.
```

## Local compilation instructions
The software package supports Github Action cloud compilation, and the compiled firmware can be downloaded directly in [Action](https://github.com/ophub/op/actions) and [Releases](https://github.com/ophub/op/releases). You can also compile locally:
1. Clone the warehouse to the local. `git clone https://github.com/ophub/op`
2. Create an `openwrt` folder in the local `op/router/s905x3_phicomm-n1` directory, and upload the compiled openwrt firmware of the ARM kernel to the openwrt directory.
3. Enter the /op root directory. Enter the phicomm_n1 directory and run `sudo ./router/s905x3_phicomm-n1/make -d` to complete the compilation. The generated openwrt firmware is in the `out` directory under the root directory.

## Detailed make compile command
- `sudo ./make -d -b n1 -k 5.9.5`: recommend. Use the default configuration, specify a kernel and a firmware for compilation.
- `sudo ./make -d -b n1_x96 -k 5.4.75_5.9.5`: Use the default configuration, specify multiple cores, and multiple firmware for compilation. use "_" to connect.
- `sudo ./make -d`: Compile all kernel versions of openwrt with the default configuration.
- `sudo ./make -d -b n1 -k 5.9.2 -s 1024`: Use the default configuration, specify a kernel, a firmware, and set the partition size for compilation.
- `sudo ./make -d -b n1_x96`: Use the default configuration, specify multiple firmware, use "_" to connect. compile all kernels.
- `sudo ./make -d -k 5.4.73_5.9.2`: Use the default configuration. Specify multiple cores, use "_" to connect.
- `sudo ./make -d -k latest`: Use the default configuration to compile the latest kernel version of the openwrt firmware.
- `sudo ./make -d -s 1024 -k 5.7.15`: Use the default configuration and set the partition size to 1024m, and only compile the openwrt firmware with the kernel version 5.7.15.
- `sudo ./make -h`: Display help information and view detailed description of each parameter.
- `sudo ./make`: If you are familiar with the relevant setting requirements of the phicomm_n1 firmware, you can follow the prompts, such as selecting the firmware you want to make, the kernel version, setting the ROOTFS partition size, etc. If you don’t know these settings, just press Enter.

| Parameter | Types | Description |
| ---- | ---- | ---- |
| -d | Defaults | Compile all cores and all firmware types. |
| -b | Build | Specify the Build firmware type. Write the build firmware name individually, such as `-b n1` . Multiple firmware use `_` connect such as `-b n1_x96` . The model represented by the relevant variable： `n1` is phicomm-n1, `x96` is X96-Max+, `hk1` is HK1-Box, `h96` is H96-Max-X3, `octopus` is Octopus-Planet. |
| -k | Kernel | Specify the kernel type. Write the kernel name individually such as `-k 5.4.50` . Multiple cores use `_` connection such as `-k 5.4.50_5.9.5` |
| -s | Size | Specify the size of the root partition in MB. The default is 1024, and the specified size must be greater than 256. Such as `-s 1024` |
| -h | help | View full documentation. |

## Compilation method

- Select ***`Build OpenWrt for S905x3 and Phicomm-N1`*** on the [Action](https://github.com/ophub/op/actions) page.
- Click the ***`Run workflow`*** button.

## Configuration file function description

| Folder/file name | Features |
| ---- | ---- |
| .config | Firmware related configuration, such as firmware kernel, file type, software package, luci-app, luci-theme, etc. |
| files | Create a files directory under the root directory of the warehouse and put the relevant files in. You can use custom files such as network/dhcp/wireless by default when compiling. |
| feeds.conf.default | Just put the feeds.conf.default file into the root directory of the warehouse, it will overwrite the relevant files in the OpenWrt source directory. |
| diy-part1.sh | Execute before updating and installing feeds, you can write instructions for modifying the source code into the script, such as adding/modifying/deleting feeds.conf.default. |
| diy-part2.sh | After updating and installing feeds, you can write the instructions for modifying the source code into the script, such as modifying the default IP, host name, theme, adding/removing software packages, etc. |
| make | Phicomm N1 OpenWrt firmware build script. |
| armbian | Multi-version kernel file directory. |
| build_kernel | Use the kernel file shared by Flippy to build this script to build the Armbian kernel of OpenWrt for Phicomm-N1. |
| install-program | Script to flash firmware to emmc. |


## .github/workflow/build-openwrt-phicomm_n1.yml related environment variable description

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
| UPLOAD_COWTRANSFER | Upload the firmware to CowTransfer.com. Default false |
| UPLOAD_WERANSFER | Upload the firmware to WeTransfer.com. Default failure |
| RECENT_LASTEST | maximum retention days for release, artifacts and logs in GitHub Release and Actions. |
| TZ | Time zone setting |
| GITHUB_REPOSITORY | Github.com Environment variables. The owner and repository name. For example, ophub/op. |
| secrets.GITHUB_TOKEN | 1. Personal center: Settings → Developer settings → Personal access tokens → Generate new token ( Name: GITHUB_TOKEN, Select: public_repo, Copy GITHUB_TOKEN's Value ). 2. Op code center: Settings → Secrets → New secret ( Name: RELEASES_TOKEN, Value: Paste GITHUB_TOKEN's Value ). |

## Firmware compilation parameters

| Option | Value |
| ---- | ---- |
| Target System | QEMU ARM Virtual Machine |
| Subtarget | ARMv8 multiplatform |
| Target Profile | Default |
| Target Images | squashfs |
| Utilities  ---> |  <*> install-program |
| LuCI -> Applications | in the file: .config |

## Firmware information

| Name | Value |
| ---- | ---- |
| Default IP | 192.168.1.1 |
| Default username | root |
| Default password | password |
| Default WIFI name | OpenWrt |
| Default WIFI password | none |
