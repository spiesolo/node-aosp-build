LOCAL_PATH := $(NODE_DIR)/deps/cares

include $(CLEAR_VARS)

LOCAL_MODULE := libcares
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/config/android

LOCAL_CFLAGS := \
    -DHAVE_CONFIG_H \
    -D_LARGEFILE_SOURCE \
    -D_FILE_OFFSET_BITS=64 \
    -D_GNU_SOURCE \
    -DCARES_BUILDING_LIBRARY

LOCAL_SRC_FILES := \
    src/ares_cancel.c \
    src/ares__close_sockets.c \
    src/ares_create_query.c \
    src/ares_data.c \
    src/ares_destroy.c \
    src/ares_expand_name.c \
    src/ares_expand_string.c \
    src/ares_fds.c \
    src/ares_free_hostent.c \
    src/ares_free_string.c \
    src/ares_gethostbyaddr.c \
    src/ares_gethostbyname.c \
    src/ares__get_hostent.c \
    src/ares_getnameinfo.c \
    src/ares_getopt.c \
    src/ares_getsock.c \
    src/ares_init.c \
    src/ares_library_init.c \
    src/ares_llist.c \
    src/ares_mkquery.c \
    src/ares_nowarn.c \
    src/ares_options.c \
    src/ares_parse_aaaa_reply.c \
    src/ares_parse_a_reply.c \
    src/ares_parse_mx_reply.c \
    src/ares_parse_naptr_reply.c \
    src/ares_parse_ns_reply.c \
    src/ares_parse_ptr_reply.c \
    src/ares_parse_soa_reply.c \
    src/ares_parse_srv_reply.c \
    src/ares_parse_txt_reply.c \
    src/ares_process.c \
    src/ares_query.c \
    src/ares__read_line.c \
    src/ares_search.c \
    src/ares_send.c \
    src/ares_strcasecmp.c \
    src/ares_strdup.c \
    src/ares_strerror.c \
    src/ares_timeout.c \
    src/ares__timeval.c \
    src/ares_version.c \
    src/ares_writev.c \
    src/bitncmp.c \
    src/inet_net_pton.c \
    src/inet_ntop.c

include $(BUILD_STATIC_LIBRARY)
