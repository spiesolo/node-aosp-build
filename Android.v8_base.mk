LOCAL_PATH := $(NODE_DIR)/deps/v8

include $(CLEAR_VARS)

LOCAL_MODULE := libv8_base
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE_TAGS := optional
intermediates := $(call local-intermediates-dir)

# Generate gen-postmortem-metadata.py
GEN := $(intermediates)/gen-postmortem-metadata.py
$(GEN): $(intermediates)/%.py : $(LOCAL_PATH)/tools/%.py | $(ACP)
	@echo "Copying $@"
	$(copy-file-to-target)

# Generate debug-support.cc
GEN := $(intermediates)/debug-support.cc
$(GEN): SCRIPT := $(intermediates)/gen-postmortem-metadata.py
$(GEN): DEBUG_SUPPORT_HEADER_FILES := $(addprefix $(LOCAL_PATH)/,src/objects.h src/objects-inl.h)
$(GEN): $(intermediates)/gen-postmortem-metadata.py
	@echo "Generating libraries.cc"
	@mkdir -p $(dir $@)
	python $(SCRIPT) $@ $(DEBUG_SUPPORT_HEADER_FILES)

ifeq ($(TARGET_ARCH), arm)
ARCH_CFLAGS := \
    -DV8_TARGET_ARCH_ARM \
    -DCAN_USE_ARMV7_INSTRUCTIONS \
    -DCAN_USE_VFP3_INSTRUCTIONS \
    -DCAN_USE_VFP32DREGS

ARCH_SRC_FILES := \
    src/arm/assembler-arm.cc \
    src/arm/builtins-arm.cc \
    src/arm/code-stubs-arm.cc \
    src/arm/codegen-arm.cc \
    src/arm/constants-arm.cc \
    src/arm/cpu-arm.cc \
    src/arm/deoptimizer-arm.cc \
    src/arm/disasm-arm.cc \
    src/arm/frames-arm.cc \
    src/arm/interface-descriptors-arm.cc \
    src/arm/macro-assembler-arm.cc \
    src/arm/simulator-arm.cc \
    src/compiler/arm/code-generator-arm.cc \
    src/compiler/arm/instruction-scheduler-arm.cc \
    src/compiler/arm/instruction-selector-arm.cc \
    src/crankshaft/arm/lithium-arm.cc \
    src/crankshaft/arm/lithium-codegen-arm.cc \
    src/crankshaft/arm/lithium-gap-resolver-arm.cc \
    src/debug/arm/debug-arm.cc \
    src/full-codegen/arm/full-codegen-arm.cc \
    src/ic/arm/access-compiler-arm.cc \
    src/ic/arm/handler-compiler-arm.cc \
    src/ic/arm/ic-arm.cc \
    src/ic/arm/ic-compiler-arm.cc \
    src/ic/arm/stub-cache-arm.cc \
    src/regexp/arm/regexp-macro-assembler-arm.cc
endif

LOCAL_CFLAGS := \
    $(ARCH_CFLAGS) \
    -DENABLE_DISASSEMBLER \
    -DV8_I18N_SUPPORT \
    -DV8_IMMINENT_DEPRECATION_WARNINGS \
    -DICU_UTIL_DATA_IMPL=ICU_UTIL_DATA_STATIC \
    -DUCONFIG_NO_TRANSLITERATION=1 \
    -DUCONFIG_NO_SERVICE=1 \
    -DUCONFIG_NO_REGULAR_EXPRESSIONS=1 \
    -DU_ENABLE_DYLOAD=0 \
    -DU_STATIC_IMPLEMENTATION=1 \
    -DU_HAVE_STD_STRING=0 \
    -DUCONFIG_NO_BREAK_ITERATION=0 \
    -DUCONFIG_NO_LEGACY_CONVERSION=1 \
    -DUCONFIG_NO_CONVERSION=1

LOCAL_GENERATED_SOURCES := \
    $(intermediates)/debug-support.cc

LOCAL_SRC_FILES := \
    src/accessors.cc \
    src/address-map.cc \
    src/allocation.cc \
    src/allocation-site-scopes.cc \
    src/api-experimental.cc \
    src/api.cc \
    src/api-arguments.cc \
    src/api-natives.cc \
    src/arguments.cc \
    src/assembler.cc \
    src/assert-scope.cc \
    src/ast/ast-expression-rewriter.cc \
    src/ast/ast-expression-visitor.cc \
    src/ast/ast-literal-reindexer.cc \
    src/ast/ast-numbering.cc \
    src/ast/ast-value-factory.cc \
    src/ast/ast.cc \
    src/ast/modules.cc \
    src/ast/prettyprinter.cc \
    src/ast/scopeinfo.cc \
    src/ast/scopes.cc \
    src/ast/variables.cc \
    src/background-parsing-task.cc \
    src/bailout-reason.cc \
    src/basic-block-profiler.cc \
    src/bignum-dtoa.cc \
    src/bignum.cc \
    src/bit-vector.cc \
    src/bootstrapper.cc \
    src/builtins.cc \
    src/cached-powers.cc \
    src/cancelable-task.cc \
    src/char-predicates.cc \
    src/code-factory.cc \
    src/code-stubs.cc \
    src/code-stubs-hydrogen.cc \
    src/codegen.cc \
    src/compilation-cache.cc \
    src/compilation-dependencies.cc \
    src/compilation-statistics.cc \
    src/compiler/access-builder.cc \
    src/compiler/access-info.cc \
    src/compiler/all-nodes.cc \
    src/compiler/ast-graph-builder.cc \
    src/compiler/ast-loop-assignment-analyzer.cc \
    src/compiler/basic-block-instrumentor.cc \
    src/compiler/branch-elimination.cc \
    src/compiler/bytecode-branch-analysis.cc \
    src/compiler/bytecode-graph-builder.cc \
    src/compiler/change-lowering.cc \
    src/compiler/c-linkage.cc \
    src/compiler/coalesced-live-ranges.cc \
    src/compiler/code-generator.cc \
    src/compiler/code-stub-assembler.cc \
    src/compiler/common-node-cache.cc \
    src/compiler/common-operator-reducer.cc \
    src/compiler/common-operator.cc \
    src/compiler/control-builders.cc \
    src/compiler/control-equivalence.cc \
    src/compiler/control-flow-optimizer.cc \
    src/compiler/dead-code-elimination.cc \
    src/compiler/escape-analysis.cc \
    src/compiler/escape-analysis-reducer.cc \
    src/compiler/frame.cc \
    src/compiler/frame-elider.cc \
    src/compiler/frame-states.cc \
    src/compiler/gap-resolver.cc \
    src/compiler/graph-reducer.cc \
    src/compiler/graph-replay.cc \
    src/compiler/graph-trimmer.cc \
    src/compiler/graph-visualizer.cc \
    src/compiler/graph.cc \
    src/compiler/greedy-allocator.cc \
    src/compiler/instruction-selector.cc \
    src/compiler/instruction-scheduler.cc \
    src/compiler/instruction.cc \
    src/compiler/int64-lowering.cc \
    src/compiler/js-builtin-reducer.cc \
    src/compiler/js-call-reducer.cc \
    src/compiler/js-context-specialization.cc \
    src/compiler/js-create-lowering.cc \
    src/compiler/js-frame-specialization.cc \
    src/compiler/js-generic-lowering.cc \
    src/compiler/js-global-object-specialization.cc \
    src/compiler/js-graph.cc \
    src/compiler/js-inlining.cc \
    src/compiler/js-inlining-heuristic.cc \
    src/compiler/js-intrinsic-lowering.cc \
    src/compiler/js-operator.cc \
    src/compiler/js-native-context-specialization.cc \
    src/compiler/js-typed-lowering.cc \
    src/compiler/jump-threading.cc \
    src/compiler/linkage.cc \
    src/compiler/liveness-analyzer.cc \
    src/compiler/live-range-separator.cc \
    src/compiler/load-elimination.cc \
    src/compiler/loop-analysis.cc \
    src/compiler/loop-peeling.cc \
    src/compiler/machine-operator-reducer.cc \
    src/compiler/machine-operator.cc \
    src/compiler/move-optimizer.cc \
    src/compiler/node-cache.cc \
    src/compiler/node-marker.cc \
    src/compiler/node-matchers.cc \
    src/compiler/node-properties.cc \
    src/compiler/node.cc \
    src/compiler/opcodes.cc \
    src/compiler/operator-properties.cc \
    src/compiler/operator.cc \
    src/compiler/osr.cc \
    src/compiler/pipeline.cc \
    src/compiler/pipeline-statistics.cc \
    src/compiler/raw-machine-assembler.cc \
    src/compiler/register-allocator.cc \
    src/compiler/register-allocator-verifier.cc \
    src/compiler/representation-change.cc \
    src/compiler/schedule.cc \
    src/compiler/scheduler.cc \
    src/compiler/select-lowering.cc \
    src/compiler/simplified-lowering.cc \
    src/compiler/simplified-operator-reducer.cc \
    src/compiler/simplified-operator.cc \
    src/compiler/source-position.cc \
    src/compiler/state-values-utils.cc \
    src/compiler/tail-call-optimization.cc \
    src/compiler/type-hint-analyzer.cc \
    src/compiler/type-hints.cc \
    src/compiler/typer.cc \
    src/compiler/value-numbering-reducer.cc \
    src/compiler/verifier.cc \
    src/compiler/wasm-compiler.cc \
    src/compiler/wasm-linkage.cc \
    src/compiler/zone-pool.cc \
    src/compiler.cc \
    src/context-measure.cc \
    src/contexts.cc \
    src/conversions.cc \
    src/counters.cc \
    src/crankshaft/compilation-phase.cc \
    src/crankshaft/hydrogen-bce.cc \
    src/crankshaft/hydrogen-canonicalize.cc \
    src/crankshaft/hydrogen-check-elimination.cc \
    src/crankshaft/hydrogen-dce.cc \
    src/crankshaft/hydrogen-dehoist.cc \
    src/crankshaft/hydrogen-environment-liveness.cc \
    src/crankshaft/hydrogen-escape-analysis.cc \
    src/crankshaft/hydrogen-gvn.cc \
    src/crankshaft/hydrogen-infer-representation.cc \
    src/crankshaft/hydrogen-infer-types.cc \
    src/crankshaft/hydrogen-instructions.cc \
    src/crankshaft/hydrogen-load-elimination.cc \
    src/crankshaft/hydrogen-mark-deoptimize.cc \
    src/crankshaft/hydrogen-mark-unreachable.cc \
    src/crankshaft/hydrogen-osr.cc \
    src/crankshaft/hydrogen-range-analysis.cc \
    src/crankshaft/hydrogen-redundant-phi.cc \
    src/crankshaft/hydrogen-removable-simulates.cc \
    src/crankshaft/hydrogen-representation-changes.cc \
    src/crankshaft/hydrogen-sce.cc \
    src/crankshaft/hydrogen-store-elimination.cc \
    src/crankshaft/hydrogen-types.cc \
    src/crankshaft/hydrogen-uint32-analysis.cc \
    src/crankshaft/hydrogen.cc \
    src/crankshaft/lithium-allocator.cc \
    src/crankshaft/lithium-codegen.cc \
    src/crankshaft/lithium.cc \
    src/crankshaft/typing.cc \
    src/date.cc \
    src/dateparser.cc \
    src/debug/debug-evaluate.cc \
    src/debug/debug-frames.cc \
    src/debug/debug-scopes.cc \
    src/debug/debug.cc \
    src/debug/liveedit.cc \
    src/deoptimizer.cc \
    src/disassembler.cc \
    src/diy-fp.cc \
    src/dtoa.cc \
    src/elements-kind.cc \
    src/elements.cc \
    src/execution.cc \
    src/extensions/externalize-string-extension.cc \
    src/extensions/free-buffer-extension.cc \
    src/extensions/gc-extension.cc \
    src/extensions/statistics-extension.cc \
    src/extensions/trigger-failure-extension.cc \
    src/external-reference-table.cc \
    src/factory.cc \
    src/fast-accessor-assembler.cc \
    src/fast-dtoa.cc \
    src/field-type.cc \
    src/fixed-dtoa.cc \
    src/flags.cc \
    src/frames.cc \
    src/full-codegen/full-codegen.cc \
    src/futex-emulation.cc \
    src/gdb-jit.cc \
    src/global-handles.cc \
    src/handles.cc \
    src/heap/array-buffer-tracker.cc \
    src/heap/memory-reducer.cc \
    src/heap/gc-idle-time-handler.cc \
    src/heap/gc-tracer.cc \
    src/heap/heap.cc \
    src/heap/incremental-marking-job.cc \
    src/heap/incremental-marking.cc \
    src/heap/mark-compact.cc \
    src/heap/object-stats.cc \
    src/heap/objects-visiting.cc \
    src/heap/remembered-set.cc \
    src/heap/scavenge-job.cc \
    src/heap/scavenger.cc \
    src/heap/spaces.cc \
    src/heap/store-buffer.cc \
    src/i18n.cc \
    src/icu_util.cc \
    src/ic/access-compiler.cc \
    src/ic/call-optimization.cc \
    src/ic/handler-compiler.cc \
    src/ic/ic-state.cc \
    src/ic/ic.cc \
    src/ic/ic-compiler.cc \
    src/identity-map.cc \
    src/interface-descriptors.cc \
    src/interpreter/bytecodes.cc \
    src/interpreter/bytecode-array-builder.cc \
    src/interpreter/bytecode-array-iterator.cc \
    src/interpreter/bytecode-register-allocator.cc \
    src/interpreter/bytecode-generator.cc \
    src/interpreter/constant-array-builder.cc \
    src/interpreter/control-flow-builders.cc \
    src/interpreter/handler-table-builder.cc \
    src/interpreter/interpreter.cc \
    src/interpreter/interpreter-assembler.cc \
    src/interpreter/interpreter-intrinsics.cc \
    src/interpreter/source-position-table.cc \
    src/isolate.cc \
    src/keys.cc \
    src/layout-descriptor.cc \
    src/log-utils.cc \
    src/log.cc \
    src/lookup.cc \
    src/machine-type.cc \
    src/messages.cc \
    src/objects-debug.cc \
    src/objects-printer.cc \
    src/objects.cc \
    src/optimizing-compile-dispatcher.cc \
    src/ostreams.cc \
    src/parsing/func-name-inferrer.cc \
    src/parsing/parameter-initializer-rewriter.cc \
    src/parsing/parser.cc \
    src/parsing/pattern-rewriter.cc \
    src/parsing/preparse-data.cc \
    src/parsing/preparser.cc \
    src/parsing/rewriter.cc \
    src/parsing/scanner-character-streams.cc \
    src/parsing/scanner.cc \
    src/parsing/token.cc \
    src/pending-compilation-error-handler.cc \
    src/perf-jit.cc \
    src/profiler/allocation-tracker.cc \
    src/profiler/cpu-profiler.cc \
    src/profiler/heap-profiler.cc \
    src/profiler/heap-snapshot-generator.cc \
    src/profiler/profile-generator.cc \
    src/profiler/sampler.cc \
    src/profiler/sampling-heap-profiler.cc \
    src/profiler/strings-storage.cc \
    src/property-descriptor.cc \
    src/property.cc \
    src/regexp/interpreter-irregexp.cc \
    src/regexp/jsregexp.cc \
    src/regexp/regexp-ast.cc \
    src/regexp/regexp-macro-assembler-irregexp.cc \
    src/regexp/regexp-macro-assembler-tracer.cc \
    src/regexp/regexp-macro-assembler.cc \
    src/regexp/regexp-parser.cc \
    src/regexp/regexp-stack.cc \
    src/register-configuration.cc \
    src/runtime-profiler.cc \
    src/runtime/runtime-array.cc \
    src/runtime/runtime-atomics.cc \
    src/runtime/runtime-classes.cc \
    src/runtime/runtime-collections.cc \
    src/runtime/runtime-compiler.cc \
    src/runtime/runtime-date.cc \
    src/runtime/runtime-debug.cc \
    src/runtime/runtime-forin.cc \
    src/runtime/runtime-function.cc \
    src/runtime/runtime-futex.cc \
    src/runtime/runtime-generator.cc \
    src/runtime/runtime-i18n.cc \
    src/runtime/runtime-internal.cc \
    src/runtime/runtime-interpreter.cc \
    src/runtime/runtime-json.cc \
    src/runtime/runtime-literals.cc \
    src/runtime/runtime-liveedit.cc \
    src/runtime/runtime-maths.cc \
    src/runtime/runtime-numbers.cc \
    src/runtime/runtime-object.cc \
    src/runtime/runtime-observe.cc \
    src/runtime/runtime-operators.cc \
    src/runtime/runtime-proxy.cc \
    src/runtime/runtime-regexp.cc \
    src/runtime/runtime-scopes.cc \
    src/runtime/runtime-simd.cc \
    src/runtime/runtime-strings.cc \
    src/runtime/runtime-symbol.cc \
    src/runtime/runtime-test.cc \
    src/runtime/runtime-typedarray.cc \
    src/runtime/runtime-uri.cc \
    src/runtime/runtime.cc \
    src/safepoint-table.cc \
    src/snapshot/code-serializer.cc \
    src/snapshot/deserializer.cc \
    src/snapshot/natives-common.cc \
    src/snapshot/partial-serializer.cc \
    src/snapshot/serializer.cc \
    src/snapshot/serializer-common.cc \
    src/snapshot/snapshot-common.cc \
    src/snapshot/snapshot-source-sink.cc \
    src/snapshot/startup-serializer.cc \
    src/startup-data-util.cc \
    src/string-builder.cc \
    src/string-stream.cc \
    src/strtod.cc \
    src/ic/stub-cache.cc \
    src/tracing/trace-event.cc \
    src/transitions.cc \
    src/type-cache.cc \
    src/type-feedback-vector.cc \
    src/type-info.cc \
    src/types.cc \
    src/typing-asm.cc \
    src/typing-reset.cc \
    src/unicode.cc \
    src/unicode-decoder.cc \
    src/utils.cc \
    src/v8.cc \
    src/v8threads.cc \
    src/version.cc \
    src/wasm/asm-wasm-builder.cc \
    src/wasm/ast-decoder.cc \
    src/wasm/encoder.cc \
    src/wasm/module-decoder.cc \
    src/wasm/wasm-js.cc \
    src/wasm/wasm-module.cc \
    src/wasm/wasm-opcodes.cc \
    src/wasm/wasm-result.cc \
    src/zone.cc \
    src/third_party/fdlibm/fdlibm.cc \
    $(ARCH_SRC_FILES)

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../icu-small/source/i18n \
    $(LOCAL_PATH)/../icu-small/source/common

LOCAL_CPPFLAGS := -std=gnu++0x
include external/stlport/libstlport.mk
LOCAL_CPP_EXTENSION := .cc
include $(BUILD_STATIC_LIBRARY)
