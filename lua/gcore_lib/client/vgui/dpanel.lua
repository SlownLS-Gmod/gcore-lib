--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local PANEL = {}

function PANEL:Init()

end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DPanel",function()
    vgui.Register("GCore:DPanel",PANEL,"DPanel")
end)