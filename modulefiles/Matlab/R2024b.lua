local moduleName = myModuleName()
local moduleVersion = myModuleVersion()

whatis("Name        : " .. moduleName)
whatis("Version     : " .. moduleVersion)
whatis("Category    : Math")
whatis("Description : MATLAB & Simulink")

local base = pathJoin("/tools/MATLAB", moduleVersion)

prepend_path("PATH", pathJoin(base, "bin"))

-- set aliases for MATLAB: matlab -desktop
set_alias("matlab", pathJoin(base, "bin", "matlab") .. " -desktop")