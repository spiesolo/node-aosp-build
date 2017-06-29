BASE_DIR ?= $(call my-dir)

include $(BASE_DIR)/Android.icu.host.icutools.mk
include $(BASE_DIR)/Android.icu.host.genccode.mk
include $(BASE_DIR)/Android.icu.host.icupkg.mk
include $(BASE_DIR)/Android.icu.host.iculslocs.mk
include $(BASE_DIR)/Android.icu.host.genrb.mk
