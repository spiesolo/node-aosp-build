BASE_DIR := $(call my-dir)

NODE_DIR ?= external/nodejs

include $(BASE_DIR)/Android.http_parser.mk
include $(BASE_DIR)/Android.libuv.mk
include $(BASE_DIR)/Android.icu.host.mk
include $(BASE_DIR)/Android.icu.mk
include $(BASE_DIR)/Android.libcares.mk
include $(BASE_DIR)/Android.openssl.mk
include $(BASE_DIR)/Android.v8.mk
include $(BASE_DIR)/Android.node.mk

#GCC_VERSION := $(shell $(TARGET_CC) -dumpversion)

#ifeq ($(filter 4.8 4.8.% 4.9 4.9.% 5.% 6.% 7.%, $(GCC_VERSION)),)
#$(warning nodejs uses 2011 C++ standard and requires a compiler with complete 2011 C++ standard feature)
#$(warning nodejs requires a feature-complete of 2011 C++ standard in order to be built)
#endif

