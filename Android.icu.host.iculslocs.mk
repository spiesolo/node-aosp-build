LOCAL_PATH := $(NODE_DIR)/deps/icu-small

include $(CLEAR_VARS)

LOCAL_MODULE := iculslocs

LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS := \
    -DUCONFIG_NO_TRANSLITERATION=1 \
    -DUCONFIG_NO_SERVICE=1 \
    -DUCONFIG_NO_REGULAR_EXPRESSIONS=1 \
    -DU_ENABLE_DYLOAD=0 \
    -DU_STATIC_IMPLEMENTATION=1 \
    -DU_HAVE_STD_STRING=0 \
    -DUCONFIG_NO_BREAK_ITERATION=0 \
    -DUCONFIG_NO_LEGACY_CONVERSION=1

LOCAL_SRC_FILES := \
    ../../tools/icu/iculslocs.cc

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/source/common \
    $(LOCAL_PATH)/source/io \
    $(LOCAL_PATH)/source/i18n \
    $(LOCAL_PATH)/source/tools/toolutil

LOCAL_STATIC_LIBRARIES := libicutools

LOCAL_CPP_EXTENSION := .cc

include $(BUILD_HOST_EXECUTABLE)
