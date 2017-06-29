LOCAL_PATH := $(NODE_DIR)/deps/icu-small

include $(CLEAR_VARS)

LOCAL_MODULE := libicudata

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE_CLASS := STATIC_LIBRARIES

intermediates := $(call local-intermediates-dir)

# Generate icutrim.py
GEN := $(intermediates)/icutrim.py
$(GEN): $(intermediates)/%.py : $(LOCAL_PATH)/../../tools/icu/%.py | $(ACP)
	@echo "Copying $@"
	$(copy-file-to-target)

# Generate icusmdt58_dat
GEN := $(intermediates)/icusmdt58.dat
$(GEN): SCRIPT := $(intermediates)/icutrim.py
$(GEN): TMPDIR := $(intermediates)/tmp
$(GEN): LOCAL_PATH := $(LOCAL_PATH)
$(GEN): $(SCRIPT)
	@echo "Generating icusmdt58.dat"
	@mkdir -p $(TMPDIR)
	python $(SCRIPT) -D $(LOCAL_PATH)/source/data/in/icudt58l.dat --delete-tmp -T $(TMPDIR) -F $(LOCAL_PATH)/../../tools/icu/icu_small.json -O icusmdt581.dat
	cp $(TMPDIR)/icusmdt581.dat $@

GENCCODE := $(BUILD_OUT_EXECUTABLES)/genccode$(BUILD_EXECUTABLE_SUFFIX)
GENRB := $(BUILD_OUT_EXECUTABLES)/genrb$(BUILD_EXECUTABLE_SUFFIX)
ICULSLOCS := $(BUILD_OUT_EXECUTABLES)/iculslocs$(BUILD_EXECUTABLE_SUFFIX)
ICUPKG := $(BUILD_OUT_EXECUTABLES)/icupkg$(BUILD_EXECUTABLE_SUFFIX)

# Generate icusmdt58_dat.c
GEN := $(intermediates)/icusmdt58_dat.c
$(GEN): ICUSMDT51_DAT := $(intermediates)/icusmdt58.dat
$(GEN): $(GENCCODE) $(GENRB) $(ICULSLOCS) $(ICUPKG) $(ICUSMDT51_DAT)
$(GEN):
	@echo "Generating icusmdt58_dat.c"
	@mkdir -p $(dir $@)
	$(GENCCODE) -d $(dir $@) $(ICUSMDT51_DAT)

LOCAL_GENERATED_SOURCES += $(intermediates)/icusmdt58_dat.c

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/source/common

include external/stlport/libstlport.mk

include $(BUILD_STATIC_LIBRARY)
