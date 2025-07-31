local moduleName = myModuleName()
local moduleVersion = myModuleVersion()

whatis("Name        : " .. moduleName)
whatis("Version     : " .. moduleVersion)
whatis("Category    : FPGA")
whatis("Description : Xilinx Vivado Design Suite")

local base = pathJoin("/tools/Xilinx/Vitis", moduleVersion)

source_sh("bash", pathJoin(base, "settings64.sh"))