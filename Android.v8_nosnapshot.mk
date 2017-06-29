LOCAL_PATH := $(NODE_DIR)/deps/v8

include $(CLEAR_VARS)

LOCAL_MODULE := libv8_nosnapshot
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE_TAGS = optional
intermediates := $(call local-intermediates-dir)

LOCAL_SRC_FILES := \
    src/snapshot/snapshot-empty.cc

LOCAL_GENERATED_SOURCES := \
    $(intermediates)/libraries.cc \
    $(intermediates)/experimental-libraries.cc \
    $(intermediates)/extras-libraries.cc \
    $(intermediates)/libraries-experimental-extras.cc

# Copy js2c.py to intermediates directory and invoke there to avoid generating
# jsmin.pyc in the source directory
GEN := $(intermediates)/js2c.py $(intermediates)/jsmin.py
$(GEN): $(intermediates)/%.py : $(LOCAL_PATH)/tools/%.py | $(ACP)
	@echo "Copying $@"
	$(copy-file-to-target)

# Generate libraries.cc
LOCAL_JS_LIBRARY_FILES := \
    src/js/macros.py src/messages.h \
    src/js/prologue.js src/js/runtime.js \
    src/js/v8natives.js src/js/symbol.js \
    src/js/array.js src/js/string.js \
    src/js/uri.js src/js/math.js \
    src/third_party/fdlibm/fdlibm.js src/js/regexp.js \
    src/js/arraybuffer.js src/js/typedarray.js \
    src/js/iterator-prototype.js src/js/generator.js \
    src/js/object-observe.js src/js/collection.js \
    src/js/weak-collection.js src/js/collection-iterator.js \
    src/js/promise.js src/js/messages.js \
    src/js/json.js src/js/array-iterator.js \
    src/js/string-iterator.js src/js/templates.js \
    src/js/spread.js src/js/proxy.js \
    src/debug/mirrors.js src/debug/debug.js \
    src/debug/liveedit.js src/js/i18n.js
GEN := $(intermediates)/libraries.cc
$(GEN): SCRIPT := $(intermediates)/js2c.py
$(GEN): LOCAL_JS_LIBRARY_FILES := $(addprefix, $(LOCAL_PATH)/, $(LOCAL_JS_LIBRARY_FILES))
$(GEN): $(intermediates)/js2c.py $(intermediates)/jsmin.py
	@echo "Generating libraries.cc"
	@mkdir -p $(dir $@)
	python $(SCRIPT) $@ CORE $(LOCAL_JS_LIBRARY_FILES)

# Generate experimental-libraries.cc
LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES := \
    src/js/macros.py src/messages.h \
    src/js/generator.js  src/js/harmony-atomics.js \
    src/js/harmony-regexp-exec.js src/js/harmony-object-observe.js \
    src/js/harmony-sharedarraybuffer.js src/js/harmony-simd.js \
    src/js/harmony-species.js src/js/harmony-unicode-regexps.js \
    src/js/harmony-string-padding.js src/js/promise-extra.js
GEN := $(intermediates)/experimental-libraries.cc
$(GEN): SCRIPT := $(intermediates)/js2c.py
$(GEN): LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES := $(addprefix, $(LOCAL_PATH)/, $(LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES))
$(GEN): $(intermediates)/js2c.py $(intermediates)/jsmin.py
	@echo "Generating experimental-libraries.cc"
	@mkdir -p $(dir $@)
	python $(SCRIPT) $@ EXPERIMENTAL $(LOCAL_JS_EXPERIMENTAL_LIBRARY_FILES)

# Generate extras-libraries.cc
GEN := $(intermediates)/extras-libraries.cc
$(GEN): SCRIPT := $(intermediates)/js2c.py
$(GEN): $(intermediates)/js2c.py $(intermediates)/jsmin.py
	@echo "Generating extras-libraries.cc"
	@mkdir -p $(dir $@)
	python $(SCRIPT) $@ EXTRAS

# Generate libraries-experimental-extras.cc
GEN := $(intermediates)/libraries-experimental-extras.cc
$(GEN): SCRIPT := $(intermediates)/js2c.py
$(GEN): $(intermediates)/js2c.py $(intermediates)/jsmin.py
	@echo "Generating libraries-experimental-extras.cc"
	@mkdir -p $(dir $@)
	python $(SCRIPT) $@ EXPERIMENTAL_EXTRAS

LOCAL_CPPFLAGS := -std=gnu++0x
include external/stlport/libstlport.mk
LOCAL_CPP_EXTENSION := .cc
include $(BUILD_STATIC_LIBRARY)
