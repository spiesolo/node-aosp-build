LOCAL_PATH := $(NODE_DIR)/deps/icu-small

include $(CLEAR_VARS)

LOCAL_MODULE := libicustubdata

LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS := \
    -DU_ATTRIBUTE_DEPRECATED= \
    -D_CRT_SECURE_NO_DEPRECATE= \
    -DU_STATIC_IMPLEMENTATION=1

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/source/common

LOCAL_SRC_FILES := \
    source/stubdata/stubdata.c

include $(BUILD_STATIC_LIBRARY)
