--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

GCore.Lib.oldFunctionVguiRegister = GCore.Lib.oldFunctionVguiRegister or vgui.Register

-- Panels Register
local panels = FindMetaTable("Panel")

local tblEdits = {
    ['DFrame'] = {
        ['Center'] = true,
        ['Close'] = true,
        ['MakePopup'] = true,
        ['ShowCloseButton'] = true,
        ['SetSize'] = true,
        ['SetPos'] = true,
        ['SetTitle'] = true,
        ['SetDraggable'] = true,
    },
    ['DPanel'] = {
        ['SetSize'] = true,
        ['SetPos'] = true,
        ['SetVisible'] = true,
    },
    ['DButton'] = {
        ['SetSize'] = true,
        ['SetPos'] = true,
        ['SetFont'] = true,
        ['SetText'] = true,
    },
    ['DTextEntry'] = {
        ['SetSize'] = true,
        ['SetPos'] = true,
        ['SetText'] = true,
        ['SetFont'] = true,
        ['SetPlaceholderText'] = true,
        ['SetPlaceholderColor'] = true,
        ['SetNumeric'] = true,
    },
    ['DCheckBox'] = {
        ['SetSize'] = true,
        ['SetPos'] = true,
        ['SetChecked'] = true,
        ['SetValue'] = true,
    },
    ['DCheckBox'] = {
        ['SetSize'] = true,
        ['SetPos'] = true,
        ['SetChecked'] = true,
        ['SetValue'] = true,
        ['SetChecked'] = true,
    },
}

function vgui.Register( name, mtable, base )
    local tblExplodeName = string.Explode(":", name)
    
    if tblExplodeName[1] == "GCore" then
        local gName = tblExplodeName[2]

        if !tblEdits[base] then return end

        for k,v in pairs(tblEdits[gName] or {}) do
            local panel = panels[k]

            if !panel then
                panel = vgui.GetControlTable(base)

                if !panel then 
                    print(name .. " not loaded")
                    continue 
                end

                panel = panel[k]
            end

            if !panel then continue end

            mtable[k] = function(self,...)
                panel(self,...)
                return self
            end
        end

        return GCore.Lib.oldFunctionVguiRegister(name,mtable,base)
    else
        return GCore.Lib.oldFunctionVguiRegister(name,mtable,base)
    end
end

-- Init Post Entity
hook.Add("InitPostEntity", "GCore:Lib:InitPostEntity:Vgui", function()
    hook.Call("GCore:Lib:CanCreateVgui")
end)
