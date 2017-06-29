LOCAL_PATH := $(NODE_DIR)/deps/uv

include $(CLEAR_VARS)

LOCAL_MODULE := libuv
LOCAL_MODULE_TAGS := optional
LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/src \
    $(LOCAL_PATH)/src/unix
LOCAL_SHARED_LIBRARIES := libdl
LOCAL_SRC_FILES = \
    src/fs-poll.c \
    src/heap-inl.h \
    src/inet.c \
    src/queue.h \
    src/threadpool.c \
    src/uv-common.c \
    src/uv-common.h \
    src/version.c \
    src/unix/async.c \
    src/unix/atomic-ops.h \
    src/unix/core.c \
    src/unix/dl.c \
    src/unix/fs.c \
    src/unix/getaddrinfo.c \
    src/unix/getnameinfo.c \
    src/unix/internal.h \
    src/unix/loop-watcher.c \
    src/unix/loop.c \
    src/unix/pipe.c \
    src/unix/poll.c \
    src/unix/process.c \
    src/unix/signal.c \
    src/unix/spinlock.h \
    src/unix/stream.c \
    src/unix/tcp.c \
    src/unix/thread.c \
    src/unix/timer.c \
    src/unix/tty.c \
    src/unix/udp.c \
    src/unix/android-ifaddrs.c \
    src/unix/pthread-fixes.c \
    src/unix/pthread-barrier.c \
    src/unix/linux-core.c \
    src/unix/linux-inotify.c \
    src/unix/linux-syscalls.c \
    src/unix/proctitle.c

include $(BUILD_SHARED_LIBRARY)
