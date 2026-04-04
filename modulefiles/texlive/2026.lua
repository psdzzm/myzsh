local moduleName = myModuleName()
local moduleVersion = myModuleVersion()

whatis("Name        : " .. moduleName)
whatis("Version     : " .. moduleVersion)
whatis("Category    : TeX")
whatis("Description : LaTeX typesetting system")

local base = pathJoin("/tools/texlive", moduleVersion)

prepend_path("PATH", pathJoin(base, "bin", "x86_64-linux"))
prepend_path("MANPATH", pathJoin(base, "texmf-dist", "doc", "man"))
prepend_path("INFOPATH", pathJoin(base, "texmf-dist", "doc", "info"))
