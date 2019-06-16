--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local PANEL = {}

function PANEL:Init()
    self.pLabel = nil 

    self.tblIconNotChecked = GCore.Lib:GetIcon('far',18,"f111")
    self.tblIconChecked = GCore.Lib:GetIcon('far',18,"f192")

    self.colCheckBox = GCore.Lib:GetColor('checkBoxColor')
end

function PANEL:SetLabel(strText,tblText)
    local intPosX, intPosY = self:GetPos()
    local pLabel = vgui.Create( "DLabel", self:GetParent() )
    pLabel:SetPos(intPosX + self:GetWide() + 10,intPosY)
    pLabel:SetText(strText)
    pLabel:SetFont(tblText.font)
    pLabel:SetTextColor(tblText.color or color_white)
    pLabel:SetMouseInputEnabled(true)
    pLabel.DoClick = function(l)
        self:Toggle()
    end
    pLabel:SizeToContents()

    self.pLabel = pLabel

    return self
end

function PANEL:SetCheckBoxColor(default,to)
    self.colCheckBox = {
        default = default,
        to = to
    }

    return self
end

function PANEL:Paint(w,h)
    local tblIcon = self.tblIconNotChecked
    local boolIsChecked = self:GetChecked()
    local col = GCore.Lib:LerpColor(
        self,
        "btnColor",
        { 
            default = self.colCheckBox.default,
            to = self.colCheckBox.to
        },
        boolIsChecked,
        7
    )

    if boolIsChecked then
        tblIcon = self.tblIconChecked
    end

    draw.SimpleText(tblIcon.text,tblIcon.font,w/2,h/2,col,1,1)
end

function PANEL:AddToRadio(pRadio)
    local intId = table.insert(pRadio.tblCheckBoxs,self)

    self.pRadio = pRadio
    self.intCheckId = intId

    return self
end

function PANEL:OnChange()
    if !self.pRadio then return end
    if !IsValid(self.pRadio) then return end

    self.pRadio:Select(self.intCheckId)
end

function PANEL:SetValueRadio(val)
    self.valRadio = val

    return self
end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DCheckBox",function()
    vgui.Register("GCore:DCheckBox",PANEL,"DCheckBox")
end)