fn main() {
    let proj_dir = std::path::Path::new(concat!(env!("CARGO_MANIFEST_DIR"), "/..")).canonicalize().unwrap();
    let iface_path = proj_dir.join("DummyInterface.json");
    let iface: oasis_rpc::Interface = serde_json::from_slice(&std::fs::read(&iface_path).unwrap()).unwrap();

    let in_wasm_path = proj_dir.join("build/hello.wasm");
    let out_wasm_path = proj_dir.join("build/hello_service.wasm");
    let mut module = walrus::Module::from_file(&in_wasm_path).unwrap();
    module.customs.add(walrus::RawCustomSection {
        name: "oasis-interface".to_string(),
        data: iface.to_vec().unwrap(),
    });
    module.emit_wasm_file(out_wasm_path).unwrap();
}
