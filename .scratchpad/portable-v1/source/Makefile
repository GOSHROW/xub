CC ?= cc
AR ?= ar
PYTHON ?= python3
BUILD ?= build
CFLAGS ?= -O2 -g
CPPFLAGS += -Iinclude -Isrc
WARNINGS = -std=c11 -Wall -Wextra -Wpedantic -Werror
LIB_OBJECTS = $(BUILD)/xub_int.o $(BUILD)/xub_mul.o

.PHONY: all test sanitize ubsan benchmark clean
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
