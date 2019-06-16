--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local PANEL = {}

function PANEL:Init()
    self.tblCheckBoxs = {}

    self:SetVisible(false)
    self:SetSize(0,0)
    self.intCheckBoxSelected = 0
end

function PANEL:Select(id)
    if !self.tblCheckBoxs[id] then return end
    if !IsValid(self.tblCheckBoxs[id]) then return end

    for k,v in pairs(self.tblCheckBoxs or {}) do
        if !IsValid(v) then continue end

        v:SetChecked(false)

        if v.intCheckId == id then
            v:SetChecked(true)
            self.intCheckBoxSelected = id
        end
    end

    return self
end

function PANEL:GetValueRadio()
    local intSelected = self.intCheckBoxSelected

    if !self.tblCheckBoxs[intSelected] then return "" end
    if !IsValid(self.tblCheckBoxs[intSelected]) then return "" end    

    return self.tblCheckBoxs[intSelected].valRadio or ""
end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DRadio",function()
    vgui.Register("GCore:DRadio",PANEL,"DPanel")
end)