cd ~
git clone https://github.com/SuperCosmicBeing/kernel_xiaomi_sleepy -b freq sleepy/ --depth=1 --single-branch
git clone https://github.com/kdrag0n/proton-clang clang/ --depth=1 --single-branch

cud=$(pwd)
echo $cud


export CC=clang
export HOSTCC=clang
export ARCH=arm64
export CROSS_COMPILE=$cud/clang/bin/aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=$cud/clang/bin/arm-linux-gnueabi-

cd sleepy
mma system/libufdt/utils/src
make O=out CC=clang HOSTCC=clang ARCH=arm64 sleepy_defconfig
make O=out CC=clang HOSTCC=clang ARCH=arm64 -j$(nproc --all)

a=$(curl --upload-file out/arch/arm64/boot/Image.gz-dtb https://transfer.sh)
echo $a
tg $id $a
exit 1
