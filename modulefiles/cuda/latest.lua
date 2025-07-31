local moduleName = myModuleName()
local moduleVersion = myModuleVersion()

whatis("Name        : " .. moduleName)
whatis("Version     : " .. moduleVersion)
whatis("Category    : Compiler")
whatis("Description : NVIDIA CUDA Toolkit")

local base = "/opt/cuda"

-- get pwd
local d, _ = splitFileName(myFileName())


source_sh("bash", pathJoin(d, "load_cuda.sh"))

append_path("LD_LIBRARY_PATH", pathJoin(base, "lib64"))
