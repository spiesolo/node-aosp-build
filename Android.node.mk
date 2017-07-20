LOCAL_PATH  := $(NODE_DIR)

ifeq ($(TOPDIR),)
TOPDIR = $(CURDIR)/
endif

include $(CLEAR_VARS)

NODE_WITH_OPENSSL ?= true

ifeq ($(NODE_WITH_OPENSSL), true)
NODE_EXTRA_SRC_FILES += \
	src/node_crypto.cc \
	src/node_crypto_bio.cc \
	src/node_crypto_clienthello.cc \
	src/tls_wrap.cc
NODE_EXTRA_CFLAGS += -DHAVE_OPENSSL=1
NODE_EXTRA_SHARED_LIBRARIES += \
    libopenssl
else
NODE_EXTRA_CFLAGS += -DHAVE_OPENSSL=0
endif

ifeq ($(NODE_WITH_INSPECTOR), true)
NODE_EXTRA_SRC_FILES += \
	src/inspector_agent.cc \
	src/inspector_socket.cc
NODE_EXTRA_CFLAGS += \
	-DHAVE_INSPECTOR=1 \
	-DV8_INSPECTOR_USE_STL=1 \
	-DV8_INSPECTOR_USE_OLD_STL=1
NODE_EXTRA_STATIC_LIBRARIES := libv8_inspector_stl
else
NODE_EXTRA_CFLAGS += -DHAVE_INSPECTOR=0
endif

# build with dtrace
ifeq ($(NODE_WITH_DTRACE), true)
NODE_EXTRA_SRC_FILES += \
    src/node_dtrace.cc
NODE_EXTRA_CFLAGS += \
    -DHAVE_DTRACE=1
endif

# build with Lttng
ifeq ($(NODE_WITH_LTTNG), true)
NODE_EXTRA_SRC_FILES += \
    src/node_lttng.cc
NODE_EXTRA_CFLAGS += \
    -DHAVE_LTTNG=1
endif

# build with performance counters
#ifeq ($(NODE_WITH_PERFCTR), true)
#NODE_EXTRA_SRC_FILES +=
#NODE_EXTRA_CFLAGS +=
#endif

LOCAL_MODULE := node
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional
intermediates := $(call local-intermediates-dir)

LOCAL_GENERATED_SOURCES := \
    $(intermediates)/node_javascript.cc

LOCAL_JS_LIBRARY_FILES := \
    lib/internal/bootstrap_node.js \
    lib/_debug_agent.js lib/_debugger.js \
    lib/assert.js lib/buffer.js \
    lib/child_process.js lib/console.js \
    lib/constants.js lib/crypto.js \
    lib/cluster.js lib/dgram.js \
    lib/dns.js lib/domain.js \
    lib/events.js lib/fs.js \
    lib/http.js lib/_http_agent.js \
    lib/_http_client.js lib/_http_common.js \
    lib/_http_incoming.js lib/_http_outgoing.js \
    lib/_http_server.js lib/https.js \
    lib/_linklist.js lib/module.js \
    lib/net.js lib/os.js \
    lib/path.js lib/process.js \
    lib/punycode.js lib/querystring.js \
    lib/readline.js lib/repl.js \
    lib/stream.js lib/_stream_readable.js \
    lib/_stream_writable.js lib/_stream_duplex.js \
    lib/_stream_transform.js lib/_stream_passthrough.js \
    lib/_stream_wrap.js lib/string_decoder.js \
    lib/sys.js lib/timers.js lib/tls.js \
    lib/_tls_common.js lib/_tls_legacy.js \
    lib/_tls_wrap.js lib/tty.js \
    lib/url.js lib/util.js \
    lib/v8.js lib/vm.js \
    lib/zlib.js \
    lib/internal/child_process.js lib/internal/cluster.js \
    lib/internal/freelist.js lib/internal/linkedlist.js \
    lib/internal/net.js lib/internal/module.js \
    lib/internal/process/next_tick.js lib/internal/process/promises.js \
    lib/internal/process/stdio.js lib/internal/process/warning.js \
    lib/internal/process.js lib/internal/readline.js \
    lib/internal/repl.js lib/internal/socket_list.js \
    lib/internal/util.js lib/internal/v8_prof_polyfill.js \
    lib/internal/v8_prof_processor.js lib/internal/streams/lazy_transform.js \
    lib/internal/streams/BufferList.js lib/internal/streams/legacy.js \
    deps/v8/tools/splaytree.js deps/v8/tools/codemap.js \
    deps/v8/tools/consarray.js deps/v8/tools/csvparser.js \
    deps/v8/tools/profile.js deps/v8/tools/profile_view.js \
    deps/v8/tools/logreader.js deps/v8/tools/tickprocessor.js \
    deps/v8/tools/SourceMap.js deps/v8/tools/tickprocessor-driver.js

# Generate node_javascript.cc
GEN := $(intermediates)/node_javascript.cc
$(GEN): LOCAL_PATH := $(LOCAL_PATH)
$(GEN): SCRIPT := tools/js2c.py
$(GEN): INTERMEDIATES := $(intermediates)/node_javascript.cc
$(GEN):
	@echo "Generating $@"
	@mkdir -p $(dir $@)
	cd $(LOCAL_PATH) && python $(SCRIPT) $(TOPDIR)$(INTERMEDIATES) $(LOCAL_JS_LIBRARY_FILES) config.gypi src/notrace_macros.py src/nolttng_macros.py src/perfctr_macros.py

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/src \
	$(LOCAL_PATH)/deps/uv/src/ares \
	$(LOCAL_PATH)/deps/v8/include \
	$(LOCAL_PATH)/deps/v8_inspector/third_party/v8_inspector \
	$(LOCAL_PATH)/deps/icu-small/source/i18n \
	$(LOCAL_PATH)/deps/icu-small/source/common \
	$(LOCAL_PATH)/deps/openssl/openssl/include \
	$(LOCAL_PATH)/deps/zlib \
	$(LOCAL_PATH)/deps/http_parser \
	$(LOCAL_PATH)/deps/cares/include \
	$(LOCAL_PATH)/deps/uv/include

LOCAL_CFLAGS := \
    -DNODE_ARCH="\"$(TARGET_ARCH)\"" \
    -DNODE_PLATFORM="\"android\"" \
    -DNODE_WANT_INTERNALS=1 \
    -DV8_DEPRECATION_WARNINGS=1 \
    -DNODE_USE_V8_PLATFORM=1 \
    -DNODE_HAVE_I18N_SUPPORT=1 \
    -DNODE_HAVE_SMALL_ICU=1 \
    -D__POSIX__ \
    -DUCONFIG_NO_TRANSLITERATION=1 \
    -DUCONFIG_NO_SERVICE=1 \
    -DUCONFIG_NO_REGULAR_EXPRESSIONS=1 \
    -DU_ENABLE_DYLOAD=0 \
    -DU_STATIC_IMPLEMENTATION=1 \
    -DU_HAVE_STD_STRING=0 \
    -DUCONFIG_NO_BREAK_ITERATION=0 \
    -DUCONFIG_NO_LEGACY_CONVERSION=1 \
    -DUCONFIG_NO_CONVERSION=1 \
    -DHTTP_PARSER_STRICT=0 \
    -D_LARGEFILE_SOURCE \
    -D_FILE_OFFSET_BITS=64 \
	$(NODE_EXTRA_CFLAGS)

LOCAL_SRC_FILES := \
    src/async-wrap.cc \
	src/cares_wrap.cc \
	src/connection_wrap.cc \
	src/connect_wrap.cc \
	src/debug-agent.cc \
	src/env.cc \
	src/fs_event_wrap.cc \
	src/handle_wrap.cc \
	src/js_stream.cc \
	src/node.cc \
	src/node_buffer.cc \
	src/node_config.cc \
	src/node_constants.cc \
	src/node_contextify.cc \
	src/node_file.cc \
	src/node_http_parser.cc \
	src/node_main.cc \
	src/node_os.cc \
	src/node_revert.cc \
	src/node_util.cc \
	src/node_v8.cc \
	src/node_stat_watcher.cc \
	src/node_watchdog.cc \
	src/node_zlib.cc \
	src/node_i18n.cc \
	src/pipe_wrap.cc \
	src/process_wrap.cc \
	src/signal_wrap.cc \
	src/spawn_sync.cc \
	src/string_bytes.cc \
	src/string_search.cc \
	src/stream_base.cc \
	src/stream_wrap.cc \
	src/tcp_wrap.cc \
	src/timer_wrap.cc \
	src/tty_wrap.cc \
	src/udp_wrap.cc \
	src/util.cc \
	src/uv.cc \
	src/backtrace_posix.cc \
	$(NODE_EXTRA_SRC_FILES)

LOCAL_STATIC_LIBRARIES := \
    libv8_base \
    libv8_nosnapshot \
    libv8_platform \
    libv8_libbase \
    libicui18n \
    libicuucx \
    libicudata \
    libicustubdata \
    libcares \
    $(NODE_EXTRA_STATIC_LIBRARIES)

LOCAL_SHARED_LIBRARIES := \
	liblog \
    libdl \
	libz \
    libhttp_parser \
    libuv \
    libgabi++ \
	$(NODE_EXTRA_SHARED_LIBRARIES)

LOCAL_CPPFLAGS := -std=gnu++0x
include $(BASE_DIR)/Android.cxxstl.mk
LOCAL_CPP_EXTENSION := .cc
include $(BUILD_EXECUTABLE)
