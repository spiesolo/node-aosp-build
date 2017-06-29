LOCAL_PATH := $(NODE_DIR)/deps/http_parser

include $(CLEAR_VARS)
LOCAL_MODULE := libhttp_parser
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := http_parser.c
LOCAL_CFLAGS := -DHTTP_PARSER_STRICT=0
include $(BUILD_SHARED_LIBRARY)

