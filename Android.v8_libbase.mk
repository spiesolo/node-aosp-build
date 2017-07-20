LOCAL_PATH := $(NODE_DIR)/deps/v8

include $(CLEAR_VARS)

LOCAL_MODULE := libv8_libbase
LOCAL_MODULE_TAGS := optional

ifeq ($(TARGET_ARCH), arm)
LOCAL_CFLAGS := \
    -DV8_TARGET_ARCH_ARM \
    -DCAN_USE_ARMV7_INSTRUCTIONS \
    -DCAN_USE_VFP3_INSTRUCTIONS \
    -DCAN_USE_VFP32DREGS \
    -DENABLE_DISASSEMBLER \
    -DV8_I18N_SUPPORT
endif

LOCAL_SRC_FILES := \
    src/base/accounting-allocator.cc \
    src/base/bits.cc \
    src/base/cpu.cc \
    src/base/division-by-constant.cc \
    src/base/functional.cc \
    src/base/logging.cc \
    src/base/once.cc \
    src/base/sys-info.cc \
    src/base/platform/condition-variable.cc \
    src/base/platform/mutex.cc \
    src/base/platform/platform-linux.cc \
    src/base/platform/platform-posix.cc \
    src/base/platform/semaphore.cc \
    src/base/platform/time.cc \
    src/base/utils/random-number-generator.cc

LOCAL_CPPFLAGS := -std=gnu++0x
include $(BASE_DIR)/Android.cxxstl.mk
LOCAL_CPP_EXTENSION := .cc
include $(BUILD_STATIC_LIBRARY)
