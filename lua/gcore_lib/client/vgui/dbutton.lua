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
    self.intBorderRadius = 0
    self.intTextAlign = 1

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
    if !self.tblTextPos then
        self.tblTextPos = {w/2,h/2}
    end

    if !self.tblTextPos[2] then
        self.tblTextPos[2] = h/2
    end

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

    draw.RoundedBox(self.intBorderRadius,0,0,w,h,col)

    if self.tblIcon then
        surface.SetFont(self:GetFont())
        local intW, intH = surface.GetTextSize(self:GetText())


        local intIconPosX = w/2-(intW/2)-10
        if intW == 0 then
            intIconPosX = w/2
        end

        draw.SimpleText(self.tblIcon.icon.text,self.tblIcon.icon.font,intIconPosX,h/2,self:GetTextColor(),1,1)
        draw.SimpleText(self:GetText(),self:GetFont(),w/2 + 10,h/2,self:GetTextColor(),1,1)
    else
        draw.SimpleText(self:GetText(),self:GetFont(),self.tblTextPos[1],self.tblTextPos[2],self:GetTextColor(),self.intTextAlign,1)
    end
end

function PANEL:SetBorderRadius(intAmount)
    self.intBorderRadius = intAmount

    return self
end

function PANEL:SetTextAlign(intAlign)
    self.intTextAlign = intAlign
    return self
end

function PANEL:SetTextPos(intX,intY)
    if !self.tblTextPos then self.tblTextPos = {} end
    
    self.tblTextPos[1] = intX

    if intY then
        self.tblTextPos[2] = intY
    end

    return self
end

function PANEL:AddOptionMenu(tblOption,boolRightClick)
    self.tblOptions = tblOption
    self.boolTblOptionOnRightClick = boolRightClick

    return self
end

function PANEL:DoRightClick()
    if self.boolTblOptionOnRightClick then
        local menu = DermaMenu()
        for k,v in SortedPairs(self.tblOptions or {}) do
            menu:AddOption(v.name,v.func)
        end
        menu:Open()
    end
end

function PANEL:DoClick()
    if !self.boolTblOptionOnRightClick then
        local menu = DermaMenu()
        for k,v in SortedPairs(self.tblOptions or {}) do
            menu:AddOption(v.name,v.func)
        end
        menu:Open()
    end
end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DButton",function()
    vgui.Register("GCore:DButton",PANEL,"DButton")
end)