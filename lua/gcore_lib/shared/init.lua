--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

GCore.Lib.Themes = GCore.Lib.Themes or {}
GCore.Lib.Themes.List = GCore.Lib.Themes.List or {}

function GCore.Lib.Themes:Add(name,tbl)
    GCore.Lib.Themes.List[name] = tbl
end
function GCore.Lib.Themes:GetCurrent()
    return GCore.Lib.Themes.Selected
end

GCore.Lib.Themes.Selected = "dark"