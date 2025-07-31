local moduleName = myModuleName()
local moduleVersion = myModuleVersion()

whatis("Name        : " .. moduleName)
whatis("Version     : " .. moduleVersion)
whatis("Category    : Compiler")
whatis("Description : RISC-V GNU Compiler Toolchain")


local base = "/opt/riscv"

prepend_path("PATH", pathJoin(base, "bin"))
-- prepend_path("LD_LIBRARY_PATH", pathJoin(base, "lib"))
prepend_path("MANPATH", pathJoin(base, "share", "man"))
prepend_path("INFOPATH", pathJoin(base, "share", "info"))