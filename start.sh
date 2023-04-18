#!/bin/sh
set -e
adb connect 192.168.42.5:5555
cd gogglesbuild
cmake \
    -DCMAKE_TOOLCHAIN_FILE=/mnt/c/Users/j005u/Play/dji/android-ndk-r23b/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=armeabi-v7a \
    -DANDROID_PLATFORM=android-23 ../ 
make -j32 
adb push ../examples /tmp/
adb push simulator/simulator /tmp 
adb shell "/tmp/simulator"