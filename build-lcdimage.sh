#/usr/bin/env sh


# Create LZMA image blob from raw images

rm -f ./__temp__images.lzma
cat ./raw/*.raw | /usr/bin/lzma -z --format=lzma --lzma1=mode=fast >> ./__temp__images.lzma


# Create header

#  16 bytes: identifier ("lcd_boot_image")
printf "%s" "lcd_boot_image" > lcd_boot_image.bin
dd if=/dev/null of=lcd_boot_image.bin bs=1 count=0 seek=16 2>/dev/null

#  12 bytes: LZMA image blob size
printf "%lu" `wc -c ./__temp__images.lzma | awk '{print $1}'` >> ./lcd_boot_image.bin
dd if=/dev/null of=lcd_boot_image.bin bs=1 count=0 seek=28 2>/dev/null

#   4 bytes: number of raw images
printf "%lu" `ls -1 ./raw/*.raw | wc -l` >> ./lcd_boot_image.bin
dd if=/dev/null of=lcd_boot_image.bin bs=1 count=0 seek=32 2>/dev/null

#  16 bytes: total size of uncompressed raw images
printf "%lu" `ls -l ./raw/*.raw | grep -v '^d' | awk '{total += $5} END {print total}'` >> ./lcd_boot_image.bin
dd if=/dev/null of=lcd_boot_image.bin bs=1 count=0 seek=48 2>/dev/null

#   4 bytes: frame time slot, in msec ("echo" as per original makefile)
echo "10" >> ./lcd_boot_image.bin
dd if=/dev/null of=lcd_boot_image.bin bs=1 count=0 seek=52 2>/dev/null

# 108 bytes: bit vector format of display images, lsb ("echo" as per original makefile)
echo "1111111111111111111111111111111111111111111111111111111111111101010101010101010110000000000" >> ./lcd_boot_image.bin
dd if=/dev/null of=lcd_boot_image.bin bs=1 count=0 seek=160 2>/dev/null


# Append LZMA image blob

cat ./__temp__images.lzma >> ./lcd_boot_image.bin
rm -f ./__temp__images.lzma


# Pad image file to align to 131072 byte block size

ALIGNEDSIZE=`wc -c lcd_boot_image.bin | awk 'function c(i){return(i==int(i))?i:int(i)+1}{print c($1/131072)*131072}'`
dd if=/dev/null of=lcd_boot_image.bin bs=1 count=0 seek=$ALIGNEDSIZE 2>/dev/null


# Done.