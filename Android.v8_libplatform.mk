LOCAL_PATH := $(NODE_DIR)/deps/v8

include $(CLEAR_VARS)

LOCAL_MODULE := libv8_platform
LOCAL_MODULE_TAGS := optional

ifeq ($(TARGET_ARCH), arm)
ARCH_CFLAGS := \
    -DV8_TARGET_ARCH_ARM \
    -DCAN_USE_ARMV7_INSTRUCTIONS \
    -DCAN_USE_VFP3_INSTRUCTIONS \
    -DCAN_USE_VFP32DREGS
endif

LOCAL_CFLAGS := \
    $(ARCH_CFLAGS) \
    -DENABLE_DISASSEMBLER \
    -DV8_I18N_SUPPORT

LOCAL_CPPFLAGS := -std=gnu++0x

LOCAL_SRC_FILES := \
    src/libplatform/default-platform.cc \
    src/libplatform/task-queue.cc \
    src/libplatform/worker-thread.cc

include external/stlport/libstlport.mk
LOCAL_CPP_EXTENSION := .cc
include $(BUILD_STATIC_LIBRARY)
