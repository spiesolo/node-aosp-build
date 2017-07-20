ifneq ($(wildcard external/stlport/libstlport.mk),)
include external/stlport/libstlport.mk
LOCAL_CFLAGS += -DUSE_STLPORT
else
LOCAL_CXX_STL := libc++
endif
