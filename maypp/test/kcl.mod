[package]
name = "test"
edition = "v0.8.0"
version = "0.0.1"

[dependencies]
konfig = { oci = "oci://ghcr.io/kcl-lang/konfig", tag = "0.5.0" }
template = { path = "../../template" }
[profile]
entries = ["../base/base.k", "main.k", "${konfig:KCL_MOD}/models/kube/render/render.k"]
