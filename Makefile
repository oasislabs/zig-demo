.PHONY: all clean

build/hello_service.wasm: build/hello.wasm attach-iface/src/main.rs
	cargo run --manifest-path attach-iface/Cargo.toml
	oasis build $@

build/hello.wasm: hello.zig | build
	zig build-exe $^ -target wasm32-wasi --output-dir $(@D) --release-small

build/hello: hello.zig | build
	zig build-exe $^ --library c --output-dir $(@D) --release-fast

build:
	mkdir build

clean:
	rm -rf build
