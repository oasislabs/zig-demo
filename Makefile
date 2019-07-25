.PHONY: all clean test

test: build/hello_service.wasm | node_modules/.installed
	node test.js

build/hello_service.wasm: build/hello.wasm attach-iface/src/main.rs
	cargo run --manifest-path attach-iface/Cargo.toml
	oasis build $@

build/hello.wasm: hello.zig | build
	zig build-exe $^ -target wasm32-wasi --output-dir $(@D) --release-small

build/hello: hello.zig | build
	zig build-exe $^ --library c --output-dir $(@D) --release-fast

build:
	@mkdir build

node_modules/.installed:
	npm install
	@touch node_modules/.installed
	git co node_modules/@oasislabs

clean:
	git clean -dfX
