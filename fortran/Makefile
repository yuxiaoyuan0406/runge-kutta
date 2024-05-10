CWD := $(shell pwd)

BUILD_ROOT := ./build

CC := $(shell which gfortran)

build_dir:
	@mkdir -p $(BUILD_ROOT)

rk: build_dir
	$(CC) -o $(BUILD_ROOT)/rk RUNG-KUTTA-2024.f

rk-pid: build_dir
	$(CC) -o $(BUILD_ROOT)/rk-pid runge-kutta-pid.f

all: rk rk-pid

.PHONY: clean
clean:
	-@rm -r $(BUILD_ROOT)
