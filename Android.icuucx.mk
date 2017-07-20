LOCAL_PATH := $(NODE_DIR)/deps/icu-small

include $(CLEAR_VARS)

LOCAL_MODULE := libicuucx

LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS := \
        -DU_COMMON_IMPLEMENTATION=1 \
        -DU_ATTRIBUTE_DEPRECATED= \
        -D_CRT_SECURE_NO_DEPRECATE= \
        -DU_STATIC_IMPLEMENTATION=1 \
        -DUCONFIG_NO_TRANSLITERATION=1 \
        -DUCONFIG_NO_SERVICE=1 \
        -DUCONFIG_NO_REGULAR_EXPRESSIONS=1 \
        -DU_ENABLE_DYLOAD=0 \
        -DU_HAVE_STD_STRING=0 \
        -DUCONFIG_NO_BREAK_ITERATION=0 \
        -DUCONFIG_NO_LEGACY_CONVERSION=1 \
        -DUCONFIG_NO_CONVERSION=1

LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/source/common

LOCAL_SRC_FILES := \
        source/common/cmemory.c source/common/cstring.c \
        source/common/cwchar.c source/common/icudataver.c \
        source/common/locmap.c source/common/propsvec.c \
        source/common/uarrsort.c source/common/ubidi.c \
        source/common/ubidiln.c source/common/ubidi_props.c \
        source/common/ubiditransform.c source/common/ubidiwrt.c \
        source/common/ucat.c source/common/uchar.c \
        source/common/ucmndata.c source/common/ucnv.c \
        source/common/ucnv_cb.c source/common/ucnv_cnv.c \
        source/common/ucnv_ct.c source/common/ucnvdisp.c \
        source/common/ucnv_err.c source/common/ucnvhz.c \
        source/common/ucnvisci.c source/common/ucnvlat1.c \
        source/common/ucnv_lmb.c source/common/ucnvscsu.c \
        source/common/ucnv_set.c source/common/ucnv_u16.c \
        source/common/ucnv_u32.c source/common/ucnv_u7.c \
        source/common/ucnv_u8.c source/common/udatamem.c \
        source/common/udataswp.c source/common/uenum.c \
        source/common/uhash.c source/common/uinvchar.c \
        source/common/ulist.c source/common/uloc_tag.c \
        source/common/umapfile.c source/common/umath.c \
        source/common/ures_cnv.c source/common/usc_impl.c \
        source/common/uscript.c source/common/ustrfmt.c \
        source/common/utf_impl.c source/common/utrace.c \
        source/common/utypes.c source/common/wintz.c \
        source/common/appendable.cpp source/common/bmpset.cpp \
        source/common/brkeng.cpp source/common/brkiter.cpp \
        source/common/bytestream.cpp source/common/bytestriebuilder.cpp \
        source/common/bytestrie.cpp source/common/bytestrieiterator.cpp \
        source/common/caniter.cpp source/common/chariter.cpp \
        source/common/charstr.cpp source/common/cstr.cpp \
        source/common/dictbe.cpp source/common/dictionarydata.cpp \
        source/common/dtintrv.cpp source/common/errorcode.cpp \
        source/common/filteredbrk.cpp source/common/filterednormalizer2.cpp \
        source/common/icuplug.cpp source/common/listformatter.cpp \
        source/common/loadednormalizer2impl.cpp source/common/locavailable.cpp \
        source/common/locbased.cpp source/common/locdispnames.cpp \
        source/common/locdspnm.cpp source/common/locid.cpp \
        source/common/loclikely.cpp source/common/locresdata.cpp \
        source/common/locutil.cpp source/common/messagepattern.cpp \
        source/common/normalizer2.cpp source/common/normalizer2impl.cpp \
        source/common/normlzr.cpp source/common/parsepos.cpp \
        source/common/patternprops.cpp source/common/pluralmap.cpp \
        source/common/propname.cpp source/common/punycode.cpp \
        source/common/putil.cpp source/common/rbbi.cpp \
        source/common/rbbidata.cpp source/common/rbbinode.cpp \
        source/common/rbbirb.cpp source/common/rbbiscan.cpp \
        source/common/rbbisetb.cpp source/common/rbbistbl.cpp \
        source/common/rbbitblb.cpp source/common/resbund_cnv.cpp \
        source/common/resbund.cpp source/common/resource.cpp \
        source/common/ruleiter.cpp source/common/schriter.cpp \
        source/common/serv.cpp source/common/servlk.cpp \
        source/common/servlkf.cpp source/common/servls.cpp \
        source/common/servnotf.cpp source/common/servrbf.cpp \
        source/common/servslkf.cpp source/common/sharedobject.cpp \
        source/common/simpleformatter.cpp source/common/stringpiece.cpp \
        source/common/stringtriebuilder.cpp source/common/ubrk.cpp \
        source/common/ucase.cpp source/common/ucasemap.cpp \
        source/common/ucasemap_titlecase_brkiter.cpp source/common/ucharstriebuilder.cpp \
        source/common/ucharstrie.cpp source/common/ucharstrieiterator.cpp \
        source/common/uchriter.cpp source/common/ucln_cmn.cpp \
        source/common/ucnv2022.cpp source/common/ucnv_bld.cpp \
        source/common/ucnvbocu.cpp source/common/ucnv_ext.cpp \
        source/common/ucnv_io.cpp source/common/ucnvmbcs.cpp \
        source/common/ucnvsel.cpp source/common/ucol_swp.cpp \
        source/common/ucurr.cpp source/common/udata.cpp \
        source/common/uhash_us.cpp source/common/uidna.cpp \
        source/common/uinit.cpp source/common/uiter.cpp \
        source/common/ulistformatter.cpp source/common/uloc.cpp \
        source/common/uloc_keytype.cpp source/common/umutex.cpp \
        source/common/unames.cpp source/common/unifiedcache.cpp \
        source/common/unifilt.cpp source/common/unifunct.cpp \
        source/common/uniset_closure.cpp source/common/uniset.cpp \
        source/common/uniset_props.cpp source/common/unisetspan.cpp \
        source/common/unistr_case.cpp source/common/unistr_case_locale.cpp \
        source/common/unistr_cnv.cpp source/common/unistr.cpp \
        source/common/unistr_props.cpp source/common/unistr_titlecase_brkiter.cpp \
        source/common/unormcmp.cpp source/common/unorm.cpp \
        source/common/uobject.cpp source/common/uprops.cpp \
        source/common/uresbund.cpp source/common/uresdata.cpp \
        source/common/uscript_props.cpp source/common/uset.cpp \
        source/common/usetiter.cpp source/common/uset_props.cpp \
        source/common/ushape.cpp source/common/usprep.cpp \
        source/common/ustack.cpp source/common/ustrcase.cpp \
        source/common/ustrcase_locale.cpp source/common/ustr_cnv.cpp \
        source/common/ustrenum.cpp source/common/ustring.cpp \
        source/common/ustr_titlecase_brkiter.cpp source/common/ustrtrns.cpp \
        source/common/ustr_wcs.cpp source/common/utext.cpp \
        source/common/util.cpp source/common/util_props.cpp \
        source/common/utrie2_builder.cpp source/common/utrie2.cpp \
        source/common/utrie.cpp source/common/uts46.cpp \
        source/common/uvector.cpp source/common/uvectr32.cpp \
        source/common/uvectr64.cpp

include abi/cpp/use_rtti.mk
include $(BASE_DIR)/Android.cxxstl.mk

include $(BUILD_STATIC_LIBRARY)
