CC ?= cc
AR ?= ar
PYTHON ?= python3
BUILD ?= build
CFLAGS ?= -O2 -g
CPPFLAGS += -Iinclude -Isrc
WARNINGS = -std=c11 -Wall -Wextra -Wpedantic -Werror
LIB_OBJECTS = $(BUILD)/xub_int.o $(BUILD)/xub_mul.o

.PHONY: all test sanitize ubsan benchmark tune tune-check profile profile-v1 clean
all: $(BUILD)/xub $(BUILD)/libxub.a

$(BUILD):
	mkdir -p "$@"

$(BUILD)/%.o: src/%.c include/xub.h src/xub_internal.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -c "$<" -o "$@"

$(BUILD)/libxub.a: $(LIB_OBJECTS)
	$(AR) rcs "$@" $(LIB_OBJECTS)

$(BUILD)/xub: $(BUILD)/main.o $(BUILD)/libxub.a
	$(CC) $(CFLAGS) $(LDFLAGS) $(BUILD)/main.o $(BUILD)/libxub.a $(LDLIBS) -o "$@"

$(BUILD)/test_xub.o: tests/test_xub.c include/xub.h src/xub_internal.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -c "$<" -o "$@"

$(BUILD)/test_xub: $(BUILD)/test_xub.o $(BUILD)/libxub.a
	$(CC) $(CFLAGS) $(LDFLAGS) $(BUILD)/test_xub.o $(BUILD)/libxub.a $(LDLIBS) -o "$@"

$(BUILD)/bench_xub.o: benchmarks/bench_xub.c include/xub.h src/xub_internal.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -c "$<" -o "$@"

$(BUILD)/bench_xub: $(BUILD)/bench_xub.o $(BUILD)/libxub.a
	$(CC) $(CFLAGS) $(LDFLAGS) $(BUILD)/bench_xub.o $(BUILD)/libxub.a $(LDLIBS) -o "$@"

benchmark: $(BUILD)/bench_xub
	$(BUILD)/bench_xub > $(BUILD)/benchmarks.csv
	@printf 'Benchmark results: %s/benchmarks.csv\n' '$(BUILD)'

$(BUILD)/tune_xub.o: benchmarks/tune_xub.c include/xub.h src/xub_internal.h | $(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -c "$<" -o "$@"

$(BUILD)/tune_xub: $(BUILD)/tune_xub.o $(BUILD)/libxub.a
	$(CC) $(CFLAGS) $(LDFLAGS) $(BUILD)/tune_xub.o $(BUILD)/libxub.a $(LDLIBS) -lm -o "$@"

tune-check: $(BUILD)/tune_xub
	$(BUILD)/tune_xub --check-only

tune: $(BUILD)/tune_xub
	$(BUILD)/tune_xub --summary $(BUILD)/tuning-summary.json > $(BUILD)/tuning.csv
	@printf 'Tuning results: %s/tuning.csv and tuning-summary.json\n' '$(BUILD)'

$(BUILD)/profile:
	mkdir -p "$@"

$(BUILD)/profile/xub_int.o: src/xub_int.c include/xub.h src/xub_internal.h benchmarks/alloc_profile.h | $(BUILD)/profile
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -DXUB_ALLOC_PROFILE -include benchmarks/alloc_profile.h -c "$<" -o "$@"

$(BUILD)/profile/xub_mul.o: src/xub_mul.c include/xub.h src/xub_internal.h benchmarks/alloc_profile.h | $(BUILD)/profile
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -DXUB_ALLOC_PROFILE -include benchmarks/alloc_profile.h -c "$<" -o "$@"

$(BUILD)/profile/alloc_profile.o: benchmarks/alloc_profile.c benchmarks/alloc_profile.h | $(BUILD)/profile
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -c "$<" -o "$@"

$(BUILD)/profile/profile_xub.o: benchmarks/profile_xub.c benchmarks/alloc_profile.h include/xub.h src/xub_internal.h | $(BUILD)/profile
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -c "$<" -o "$@"

$(BUILD)/profile/profile_xub: $(BUILD)/profile/profile_xub.o $(BUILD)/profile/alloc_profile.o $(BUILD)/profile/xub_int.o $(BUILD)/profile/xub_mul.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o "$@"

profile: $(BUILD)/profile/profile_xub
	$(BUILD)/profile/profile_xub > $(BUILD)/profile/allocations.csv
	@printf 'Allocation profile: %s/profile/allocations.csv\n' '$(BUILD)'

V1_SOURCE = .scratchpad/portable-v1/source

$(BUILD)/profile-v1:
	mkdir -p "$@"

$(BUILD)/profile-v1/xub_int.o: $(V1_SOURCE)/src/xub_int.c $(V1_SOURCE)/include/xub.h $(V1_SOURCE)/src/xub_internal.h benchmarks/alloc_profile.h | $(BUILD)/profile-v1
	$(CC) -I$(V1_SOURCE)/include -I$(V1_SOURCE)/src $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -DXUB_ALLOC_PROFILE -include benchmarks/alloc_profile.h -c "$<" -o "$@"

$(BUILD)/profile-v1/xub_mul.o: $(V1_SOURCE)/src/xub_mul.c $(V1_SOURCE)/include/xub.h $(V1_SOURCE)/src/xub_internal.h benchmarks/alloc_profile.h | $(BUILD)/profile-v1
	$(CC) -I$(V1_SOURCE)/include -I$(V1_SOURCE)/src $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -DXUB_ALLOC_PROFILE -include benchmarks/alloc_profile.h -c "$<" -o "$@"

$(BUILD)/profile-v1/alloc_profile.o: benchmarks/alloc_profile.c benchmarks/alloc_profile.h | $(BUILD)/profile-v1
	$(CC) $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -c "$<" -o "$@"

$(BUILD)/profile-v1/profile_xub.o: benchmarks/profile_xub.c benchmarks/alloc_profile.h $(V1_SOURCE)/include/xub.h $(V1_SOURCE)/src/xub_internal.h | $(BUILD)/profile-v1
	$(CC) -I$(V1_SOURCE)/include -I$(V1_SOURCE)/src $(CPPFLAGS) $(CFLAGS) $(WARNINGS) -DXUB_PROFILE_V1 -c "$<" -o "$@"

$(BUILD)/profile-v1/profile_xub: $(BUILD)/profile-v1/profile_xub.o $(BUILD)/profile-v1/alloc_profile.o $(BUILD)/profile-v1/xub_int.o $(BUILD)/profile-v1/xub_mul.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o "$@"

profile-v1: $(BUILD)/profile-v1/profile_xub
	$(BUILD)/profile-v1/profile_xub > $(BUILD)/profile-v1/allocations.csv
	@printf 'Archived-v1 allocation profile: %s/profile-v1/allocations.csv\n' '$(BUILD)'

test: all $(BUILD)/test_xub
	$(BUILD)/test_xub
	$(PYTHON) tests/oracle.py --binary $(BUILD)/xub --output $(BUILD)/oracle-results.json

sanitize:
	$(MAKE) BUILD=build/sanitize CFLAGS='-O1 -g -fsanitize=address,undefined -fno-omit-frame-pointer' LDFLAGS='-fsanitize=address,undefined' all build/sanitize/test_xub
	UBSAN_OPTIONS=halt_on_error=1 build/sanitize/test_xub
	UBSAN_OPTIONS=halt_on_error=1 $(PYTHON) tests/oracle.py --binary build/sanitize/xub --quick --output build/sanitize/oracle-results.json

ubsan:
	$(MAKE) BUILD=build/ubsan CFLAGS='-O1 -g -fsanitize=undefined -fno-omit-frame-pointer' LDFLAGS='-fsanitize=undefined' all build/ubsan/test_xub
	UBSAN_OPTIONS=halt_on_error=1 build/ubsan/test_xub
	UBSAN_OPTIONS=halt_on_error=1 $(PYTHON) tests/oracle.py --binary build/ubsan/xub --quick --output build/ubsan/oracle-results.json

clean:
	rm -rf build
