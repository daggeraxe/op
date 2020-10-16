#!/bin/sh

die() {
    echo -e "\033[1;31mError:\033[0m $1" && exit 1
}

#Support the input of optional parameters (x96/hk1/n1), When flashing any original firmware into emmc, and adapt the model specified by the parameter. 
#The default is N1 model (no parameters)
firmware_list="x96 hk1 n1"
firmware_dtb=${1}

emmc=$(lsblk | grep -oE 'mmcblk[0-9]' | sort | uniq)
sd=$(lsblk | grep -oE 'sd[a-z]' | sort | uniq)

[ "$emmc" ] || die "no emmc found!!"
[ "$sd" ] || die "no usb device found!!"

sd=$(lsblk | grep -wE '/|/overlay' | grep -oE 'sd[a-z]')
[ "$sd" ] || die "you are running in emmc mode, please boot system with usb!!"

dev_emmc="/dev/$emmc"
dev_sd="/dev/$sd"

echo -e "emmc: $dev_emmc\nusb:  $dev_sd\n"

part_boot="${dev_emmc}p1"
part_root="${dev_emmc}p2"
part_data="${dev_emmc}p3"

if grep -q $dev_emmc /proc/mounts; then
    # echo "umount emmc..."
    umount -f ${dev_emmc}p* 2>/dev/null
fi

if [ $(blkid | grep -E 'BOOT_EMMC|ROOT_EMMC|DATA' | wc -l) != 3 ]; then
    # parted -v >/dev/null 2>&1 || die "package parted not found!!"

    echo "backup u-boot..."
    dd if=$dev_emmc of=u-boot.img bs=1M count=4 2>/dev/null

    echo "create mbr and partition..."
    parted -s $dev_emmc mklabel msdos
    parted -s $dev_emmc mkpart primary fat32 700M 956M
    parted -s $dev_emmc mkpart primary ext4 957M 1981M
    parted -s $dev_emmc mkpart primary ext4 1982M 100%

    echo "restore u-boot..."
    dd if=u-boot.img of=$dev_emmc conv=fsync bs=1 count=442 2>/dev/null
    dd if=u-boot.img of=$dev_emmc conv=fsync bs=512 skip=1 seek=1 2>/dev/null

    sync

    if grep -q $dev_emmc /proc/mounts; then
        # echo "umount emmc..."
        umount -f ${dev_emmc}p* 2>/dev/null
    fi

    echo "format boot partiton..."
    mkfs.fat -F 32 -n "BOOT_EMMC" $part_boot >/dev/null

    echo "format root partiton..."
    mke2fs -t ext4 -F -q -L "ROOT_EMMC" -m 0 $part_root >/dev/null
    e2fsck -n $part_root >/dev/null

    echo "format data partiton..."
    mke2fs -t ext4 -F -q -L "DATA" -m 0 $part_data >/dev/null
    e2fsck -n $part_data >/dev/null
fi

ins_boot="/install/boot"
ins_root="/install/root"

mkdir -p -m 777 $ins_boot $ins_root

# echo "mount bootfs..."
mount -t vfat $part_boot $ins_boot
rm -rf $ins_boot/*

echo "copy bootable file..."
grep -wq '/boot' /proc/mounts || mount -t vfat ${dev_sd}1 /boot
rm -rf /boot/'System Volume Information'
cp -r /boot/* $ins_boot
sync

echo "edit uEnv..."
uuid=$(blkid ${dev_emmc}p2 | awk '{ print $3 }' | cut -d '"' -f 2)
if [ "$uuid" ]; then
   sed -i "s/LABEL=ROOTFS/UUID=$uuid/" $ins_boot/uEnv.txt
else
   sed -i 's/ROOTFS/ROOT_EMMC/' $ins_boot/uEnv.txt
fi

if [ -n "${firmware_dtb}" ]; then
    
    echo "edit uEnv for ${firmware_dtb}."

        old_n1_dtb="FDT=\/dtb\/amlogic\/meson-gxl-s905d-phicomm-n1.dtb"
        new_n1_dtb="#FDT=\/dtb\/amlogic\/meson-gxl-s905d-phicomm-n1.dtb"
        sed -i "s/${old_n1_dtb}/${new_n1_dtb}/g" $ins_boot/uEnv.txt
        echo "dtb_close: meson-gxl-s905d-phicomm-n1.dtb"
        
        old_x96_100dtb="FDT=\/dtb\/amlogic\/meson-sm1-x96-max-plus-100m.dtb"
        new_x96_100dtb="#FDT=\/dtb\/amlogic\/meson-sm1-x96-max-plus-100m.dtb"
        sed -i "s/${old_x96_100dtb}/${new_x96_100dtb}/g" $ins_boot/uEnv.txt
        echo "dtb_close: meson-sm1-x96-max-plus-100m.dtb"
        
        old_x96_1000dtb="FDT=\/dtb\/amlogic\/meson-sm1-x96-max-plus.dtb"
        new_x96_1000dtb="#FDT=\/dtb\/amlogic\meson-sm1-x96-max-plus.dtb"
        sed -i "s/${old_x96_1000dtb}/${new_x96_1000dtb}/g" $ins_boot/uEnv.txt
        echo "dtb_close: meson-sm1-x96-max-plus.dtb"

        old_hk1_dtb="FDT=\/dtb\/amlogic\/meson-sm1-hk1box-vontar-x3.dtb"
        new_hk1_dtb="#FDT=\/dtb\/amlogic\/meson-sm1-hk1box-vontar-x3.dtb"
        sed -i "s/${old_hk1_dtb}/${new_hk1_dtb}/g" $ins_boot/uEnv.txt
        echo "dtb_close: meson-sm1-hk1box-vontar-x3.dtb"
        
        sync

    case "${firmware_dtb}" in
    x96)
        old_x96_1000dtb="#FDT=\/dtb\/amlogic\/meson-sm1-x96-max-plus.dtb"
        new_x96_1000dtb="FDT=\/dtb\/amlogic\meson-sm1-x96-max-plus.dtb"
        sed -i "s/${old_x96_1000dtb}/${new_x96_1000dtb}/g" $ins_boot/uEnv.txt
        echo "dtb_open: meson-sm1-x96-max-plus.dtb"
        ;;
    hk1)
        old_hk1_dtb="#FDT=\/dtb\/amlogic\/meson-sm1-hk1box-vontar-x3.dtb"
        new_hk1_dtb="FDT=\/dtb\/amlogic\/meson-sm1-hk1box-vontar-x3.dtb"
        sed -i "s/${old_hk1_dtb}/${new_hk1_dtb}/g" $ins_boot/uEnv.txt
        echo "dtb_open: meson-sm1-hk1box-vontar-x3.dtb"
        ;;
    n1)
        old_n1_dtb="#FDT=\/dtb\/amlogic\/meson-gxl-s905d-phicomm-n1.dtb"
        new_n1_dtb="FDT=\/dtb\/amlogic\/meson-gxl-s905d-phicomm-n1.dtb"
        sed -i "s/${old_n1_dtb}/${new_n1_dtb}/g" $ins_boot/uEnv.txt
        echo "dtb_open: meson-gxl-s905d-phicomm-n1.dtb"
        ;;
    *)
        die "Parameter error: ${firmware_dtb}. Can parameters: x96/hk1/n1"
        ;;
    esac
    
    sync
    
fi

rm -f $ins_boot/s9*
rm -f $ins_boot/aml*
rm -f $ins_boot/boot.ini
mv -f $ins_boot/boot-emmc.scr $ins_boot/boot.scr

# echo "umount bootfs..."
umount -f $part_boot

# echo "mount rootfs..."
mount -t ext4 $part_root $ins_root
rm -rf $ins_root/*

echo "copy rootfs..."

cd /
echo " --> copy bin..."
tar -cf - bin | (cd $ins_root; tar -xpf -)
echo " --> copy etc..."
tar -cf - etc | (cd $ins_root; tar -xpf -)
echo " --> copy lib..."
tar -cf - lib | (cd $ins_root; tar -xpf -)
echo " --> copy root..."
tar -cf - root | (cd $ins_root; tar -xpf -)
echo " --> copy sbin..."
tar -cf - sbin | (cd $ins_root; tar -xpf -)
echo " --> copy usr..."
tar -cf - usr | (cd $ins_root; tar -xpf -)
echo " --> copy www..."
tar -cf - www | (cd $ins_root; tar -xpf -)

[ -f init ] && cp -f init $ins_root

cd $ins_root
mkdir boot dev mnt opt overlay proc rom run sys tmp

echo " --> link lib64..."
ln -sf lib lib64
echo " --> link var..."
ln -sf tmp var

cp etc/config/fstab etc/config/fstab.bak

backups=$(ls /opt | grep 'backup-OpenWrt.*.tar.gz$')
[ "$backups" ] && {
    for x in $backups; do backtgz=$x; done
    echo && read -p "found latest configuration backups: $backtgz, 
do you want to restore it? [Y/n] " yn
    case $yn in
    n | N) yn='n' ;;
    *) yn='y' ;;
    esac
    [ "$yn" = "y" ] && {
        echo "restore backups..."
        backtgz="/opt/$backtgz"
        tar -xzf $backtgz
    }
    echo ""
}

cp etc/config/fstab.bak etc/config/fstab

echo "edit fstab..."
sed -i "s/'BOOT'/'BOOT_EMMC'/" etc/config/fstab
if [ "$uuid" ]; then
    sed -i -e '/ROOTFS/ s/label/uuid/' etc/config/fstab
    sed -i "s/ROOTFS/$uuid/" etc/config/fstab
else
    sed -i 's/ROOTFS/ROOT_EMMC/' etc/config/fstab
fi

macaddr=$(uuidgen | md5sum | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/fc:\1:\2:\3:\4:\5/')
[ "$macaddr" ] && {
    (
        cd lib/firmware/brcm
        sdio="brcmfmac43455-sdio.phicomm,n1.txt"
        [ -f $sdio ] || ln -s brcmfmac43455-sdio.txt $sdio
        sed -i "s/macaddr=b8:27:eb:74:f2:6c/macaddr=$macaddr/" $sdio
    )
}

rm -f usr/bin/n1-install

echo "sync..."
cd /
sync

# echo "umount rootfs..."
umount -f $part_root

rm -rf install

echo "copy openwrt os to emmc done!"
