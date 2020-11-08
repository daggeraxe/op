# Change Log
The version update instructions record each important update point for everyone to track and understand.

## Release Notes
- Date: Version update date.
- Importance: The difference between five stars, the more stars the more important.
- Types: UPDATE / TOOL / BUG
- description: Detailed description of the update.
- Path: Link to related files.
- Firmware: Targeted OpenWrt firmware.

| Date | Firmware | Types | Importance | Path | description |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 2020.11.08 | Phicomm-N1, S905x3-Boxs | TOOL | 3 | [update_dtb.sh](https://github.com/ophub/op/blob/main/router/phicomm_n1/build_kernel/update_dtb.sh) | Update kernel.tar.xz files in the kernel directory with the latest dtb file. |
| 2020.11.08 | Phicomm-N1, S905x3-Boxs | UPDATE | 1 | [make_use_img.sh](https://github.com/ophub/op/blob/main/router/phicomm_n1/build_kernel/make_use_img.sh) | When the kernel is extracted, if the file lacks a key *.dtb file, the supplement will be extracted from the dtb library. |
| 2020.11.08 | Phicomm-N1, S905x3-Boxs | UPDATE | 1 | [make_use_kernel.sh](https://github.com/ophub/op/blob/main/router/phicomm_n1/build_kernel/make_use_kernel.sh) | When the kernel is extracted, if the file lacks a key *.dtb file, the supplement will be extracted from the dtb library. |
| 2020.11.08 | Phicomm-N1, S905x3-Boxs | UPDATE | 3 | [s905x3-install.sh](https://github.com/ophub/op/blob/main/router/phicomm_n1/install-program/files/s905x3-install.sh) | Added that if the dtb file is missing during installation, the download path will be prompted. |
