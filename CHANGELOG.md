# Change Log
The version update instructions record each important update point for everyone to track and understand.

## Release Notes
- Date: Version update date.
- Importance: The difference between five stars, the more stars the more important.
- Types: ADD / UPDATE / TOOL / BUG
- description: Detailed description of the update.
- Path: Link to related files.
- Firmware: Targeted OpenWrt firmware.

| Date | Firmware | Types | Importance | Path | description |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 2020.11.25 | S905x3 | UPDATE | ✩✩✩ | [s905x3-install.sh](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1) | Optimized s905x3-box installation and upgrade commands. |
| 2020.11.14 | N1, S905x3 | ADD | ✩✩✩ | [5.9.8](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1/armbian/phicomm-n1/kernel/5.9.8) | Add New kernel. |
| 2020.11.14 | N1, S905x3 | ADD | ✩✩✩ | [5.7.7](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1/armbian/phicomm-n1/kernel/5.7.7) | Add New kernel. |
| 2020.11.13 | N1 | UPDATE | ✩✩✩ | [n1-update.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/install-program/files/n1-update.sh) | Upgraded the Phicomm-N1 upgrade script, which supports booting from the USB hard disk to upgrade. |
| 2020.11.12 | N1, S905x3 | UPDATE | ✩✩✩✩✩ | [make](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/make) | When the openwrt firmware is packaged, the auto-complete installation/update file and BootLoader file are added. |
| 2020.11.11 | N1, S905x3 | UPDATE | ✩✩✩✩✩ | [s905x3_phicomm-n1](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1) | Because s905x3 and phicomm-n1 have the same code, they are merged into one. Compiling a firmware separately can be specified in the parameter -b, such as `-b n1`. Multiple firmwares are compiled together and connected with underscore, such as `-b n1_x96_hk1`. |
| 2020.11.09 | S905x3 | UPDATE | ✩✩✩ | [make](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/make) | Independent configuration of s905x3, supporting configuration of files such as .config. The compilation script of phicomm-n1 is transplanted, and the -b parameter is added to support the simultaneous compilation of multiple firmwares. For example, `./make -d -b x96_hk1`. The -k parameter is expanded to support the simultaneous compilation of multiple kernels, such as `./make -d -k 5.4.60_5.9.5`. |
| - | N1 | UPDATE | ✩✩✩ | [make](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/make) | Add the -b parameter to support compiling multiple firmwares at the same time. For example, `./make -d -b n1_x96`. The -k parameter is expanded to support the simultaneous compilation of multiple kernels, such as `./make -d -k 5.4.60_5.9.5`. |
| 2020.11.08 | N1, S905x3 | TOOL | ✩✩✩ | [dtb-amlogic](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1/armbian/dtb-amlogic) | The dtb library is added to facilitate the lack of corresponding boot files when compiling the firmware of related models with the old version of the kernel file. |
| - | N1, S905x3 | TOOL | ✩✩✩ | [update_dtb.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/build_kernel/update_dtb.sh) | Update kernel.tar.xz files in the kernel directory with the latest dtb file. |
| - | N1, S905x3 | UPDATE | ✩✩✩✩✩ | [kernel](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1/armbian/phicomm-n1/kernel) | Supplement the old version of the kernel with the latest dtb file. |
| - | N1, S905x3 | UPDATE | ✩✩✩ | [make_use_img.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/build_kernel/make_use_img.sh) | When the kernel is extracted, if the file lacks a key .dtb file, the supplement will be extracted from the dtb library. |
| - | N1, S905x3 | UPDATE | ✩✩✩ | [make_use_kernel.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/build_kernel/make_use_kernel.sh) | When the kernel is extracted, if the file lacks a key .dtb file, the supplement will be extracted from the dtb library. |
| - | N1, S905x3 | UPDATE | ✩✩ | [s905x3-install.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/install-program/files/s905x3-install.sh) | Added that if the dtb file is missing during installation, the download path will be prompted. |
| 2020.11.07 | N1, S905x3 | ADD | ✩✩ | [5.4.75](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1/armbian/phicomm-n1/kernel/5.4.75) | Add New kernel. |
| - | N1, S905x3 | ADD | ✩✩ | [5.9.5](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1/armbian/phicomm-n1/kernel/5.9.5) | Add New kernel. |
| - | N1, S905x3 | UPDATE | ✩✩ | [make_use_img.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/build_kernel/make_use_img.sh) | Add fuzzy matching function. When the version specified by the script is not found, other firmware will be searched from the flippy directory. Thus, you can directly put the kernel file you want to use into the flippy directory for extraction, without manually changing the relevant parameters each time. |
| - | N1, S905x3 | UPDATE | ✩✩ | [make_use_kernel.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/build_kernel/make_use_kernel.sh) | Add fuzzy matching function. When the version specified by the script is not found, other firmware will be searched from the flippy directory. Thus, you can directly put the kernel file you want to use into the flippy directory for extraction, without manually changing the relevant parameters each time. |
| 2020.11.05 | S905x3 | UPDATE | ✩✩ | [build-openwrt-s905x3-phicomm_n1.yml](https://github.com/ophub/op/blob/main/.github/workflows/build-openwrt-s905x3-phicomm_n1.yml) | Use the environment variable GITHUB_REPOSITORY to replace ophub/op, so that fork users can call their own compiled phicomm-n1 firmware to compile the s905x3-boxs series firmware instead of pointing to the releases of this warehouse. |
| - | N1 | UPDATE | ✩✩ | [test-build-s905x3-phicomm_n1.yml](https://github.com/ophub/op/blob/main/.github/workflows/test-build-s905x3-phicomm_n1.yml) | Use the environment variable GITHUB_REPOSITORY to replace ophub/op, so that fork users can call their own compiled phicomm-n1 firmware to compile the new version of the firmware instead of pointing to the releases in this warehouse. |
| 2020.11.03 | All | UPDATE | ✩✩ | [.config](https://github.com/ophub/op/blob/main/router/x64/.config) | Several software packages such as lsblk are integrated by default when the firmware is compiled, which supports later use in firmware maintenance. |
| 2020.11.01 | N1, S905x3 | ADD | ✩✩✩✩✩ | [s905x3-install.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/install-program/files/s905x3-install.sh) | Added the function of writing emmc partition to s905x3 series boxes. |
| - | N1, S905x3 | ADD | ✩✩✩✩✩ | [s905x3-update.sh](https://github.com/ophub/op/blob/main/router/s905x3_phicomm-n1/install-program/files/s905x3-update.sh) | Added the function of updating emmc partition firmware to s905x3 series boxes. |
| 2020.10.25 | s905x3 | ADD | ✩✩ | [s905x3](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1) | Add OpenWrt Firmware for S905x3. |
| 2020.10.01 | NanoPi-R2S | ADD | ✩✩ | [NanoPi-R2S](https://github.com/ophub/op/tree/main/router/nanopi_r2s) | Add OpenWrt Firmware for NanoPi-R2S. |
| 2020.09.01 | N1 | ADD | ✩✩ | [Phicomm-N1](https://github.com/ophub/op/tree/main/router/s905x3_phicomm-n1) | Add OpenWrt Firmware for Phicomm-N1. |
| 2020.08.10 | WRT32X | ADD | ✩✩ | [WRT32X](https://https://github.com/ophub/op/tree/main/router/linksys_wrt32x) | Add OpenWrt Firmware for Linksys WRT32X. |
| 2020.08.10 | WRT3200ACM | ADD | ✩✩ | [WRT3200ACM](https://github.com/ophub/op/tree/main/router/linksys_wrt3200acm) | Add OpenWrt Firmware for Linksys WRT3200ACM. |
| 2020.08.10 | WRT1900ACS | ADD | ✩✩ | [WRT1900ACS](https://github.com/ophub/op/tree/main/router/linksys_wrt1900acs) | Add OpenWrt Firmware for Linksys WRT1900ACS. |
| 2020.08.01 | x86_64 | ADD | ✩✩ | [x86_64](https://github.com/ophub/op/tree/main/router/x86_64) | Add OpenWrt Firmware for x86_64. |
| 2020.07.23 | - | ADD | ✩ | [op](https://github.com/ophub/op) | Open this Github. |

