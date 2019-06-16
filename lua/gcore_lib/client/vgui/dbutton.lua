--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local PANEL = {}

function PANEL:Init()
    self.tblLerps = {}
    self:SetText('')
    self:SetTextColor(color_white)
    self.strText = ""

    self.col = GCore.Lib:GetColor('buttonColor')
end

function PANEL:SetDefaultText(strText,tblIcon)
    if tblIcon then
        self.tblIcon = {
            infos = tblIcon,
            icon = GCore.Lib:GetIcon(tblIcon.type,tblIcon.size or 18,tblIcon.unicode)
        }
    end

    self.strText = strText

    return self
end

function PANEL:SetBackgroundColor(default,to)
    self.col = {
        default = default,
        to = to
    }

    return self
end

function PANEL:GetText()
    return self.strText
end

function PANEL:Paint(w,h)
    local col = GCore.Lib:LerpColor(
            self,
            "btnColor",
            { 
                default = self.col.default,
                to = self.col.to
            },
            self:IsHovered(),
            7
        )

    surface.SetDrawColor(col)
    surface.DrawRect(0,0,w,h)

    if self.tblIcon then
        surface.SetFont(self:GetFont())
        local intW, intH = surface.GetTextSize(self:GetText())

        draw.SimpleText(self.tblIcon.icon.text,self.tblIcon.icon.font,w/2-intW,h/2,self:GetTextColor(),1,1)
        draw.SimpleText(self:GetText(),self:GetFont(),w/2,h/2,self:GetTextColor(),1,1)
    else
        draw.SimpleText(self:GetText(),self:GetFont(),w/2,h/2,self:GetTextColor(),1,1)
    end
end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DButton",function()
    vgui.Register("GCore:DButton",PANEL,"DButton")
end)