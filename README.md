# easybox904-bootanimation

A small shell script that builds a flashable image for the Astoria/Arcadyan/Arcor/Vodafone
**EasyBox 904 xdsl**(and probably LTE)
to replace the original boot animation and instructions. Based on the original makefile, but modified to use xz-tools' lzma and slightly improved.

## Requirements and prerequisites
* xz-tools (necessary for lzma compression)
* 91 raw image files (320x240 Pixel, 8 bits for each R, G, B), in order:
  * 81 single animation frames
  * 10 info slides for various states of the rescue process (5 slides, repeated twice but not in the same order, please see filenames in the provided examples)
  
This repository provides PNG images for an OpenWrt boot animation as well as the respective raw files. 
  
## Flashing
The resulting image file can be flashed to the Easybox from the Easybox itself running OpenWrt/LEDE:
```
# mtd write easybox904xdsl_lcdimage.bin lcdimage
```
