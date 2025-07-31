local moduleName = myModuleName()
local moduleVersion = myModuleVersion()

whatis("Name        : " .. moduleName)
whatis("Version     : " .. moduleVersion)
whatis("Category    : Compiler")
whatis("Description : Rust Programming Language")

local base = "/tools/rust"

setenv("CARGO_HOME", pathJoin(base, "cargo"))
setenv("RUSTUP_HOME", pathJoin(base, "rustup"))

source_sh("bash", pathJoin(base, "cargo", "env"))

prepend_path("MANPATH", pathJoin(base, "rustup", "toolchains", "stable-x86_64-unknown-linux-gnu", "share", "man"))