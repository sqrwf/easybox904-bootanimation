# easybox904-bootanimation

A small shell script that builds a flashable image for the Astoria/Arcadyan/Arcor/Vodafone **EasyBox 904 xDSL** (and probably LTE)
to replace the original boot animation and instruction images. It is based on the operation of the original makefile, modified to use xz-tools' lzma and replacing the external padding script with dd commands.

## Requirements and prerequisites
* xz-tools (necessary for lzma compression)
* 91 raw image files (320x240 Pixel, 8 bits for each R, G, B), in the proper order:
  * 81 single animation frames
  * 10 info images for various states of the rescue process (5 slides, for some reason repeated twice but not in the same order, please see filenames in the provided examples)
  
This repository provides PNG images for an OpenWrt boot animation as well as the respective raw files. 
  
## Flashing
The resulting image file can be flashed to the Easybox from the Easybox itself running OpenWrt/LEDE:
```
# mtd write lcd_boot_image.bin lcdimage
```

## Notes and possible improvements
* The resulting image should also work on the Easybox 904 LTE, but lacking the hardware I did not test that myself. Try at your own risk.
