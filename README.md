# node-aosp-build

Includes a set of Android makefile scripts (Android.mk) for use with build and integration of nodejs into AOSP SDK.

Unlike the standalone Android NDK, which uses gnustl by default (can use --stl option for stl selection), AOSP SDK uses stlport. Due to the fact that stlport is not longer active and new features in C++11 might be missing in stlport, it needs patching in nodejs in order to build with stlport.

Same reason for C++11 standard, older gcc compiler might not work either. I have tried gcc 4.6 & 4.7, both of them failed to build the nodejs and eventually I use gcc 4.9 for compilation.

To use these scripts, just clone it into aosp/external and defines NODE_DIR in BoardConfig.mk file specifying where nodejs is located.
