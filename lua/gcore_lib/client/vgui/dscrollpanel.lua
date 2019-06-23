--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local PANEL = {}

function PANEL:Init()
    self:PaintScrollBar(GCore.Lib:GetColor('primary'),GCore.Lib:GetColor('secondary'),GCore.Lib:GetColor('secondary'),GCore.Lib:GetColor('lightRed'))
end

function PANEL:AddIconLayout(intX,intY)
    local pList = vgui.Create("DIconLayout",self)
    pList:Dock( FILL )
    pList:SetSpaceX( intX or 0 )
    pList:SetSpaceY( intY or 0 )

    self.pIconLayout = pList

    return self
end

function PANEL:GetIconLayout()
    return self.pIconLayout
end

function PANEL:PaintScrollBar(colBase,colUp,colDown,colGrip)
    local pBar = self:GetVBar()
    function pBar:Paint(w,h)
        surface.SetDrawColor(colBase)
        surface.DrawRect(0,5,w,h)
    end
    function pBar.btnUp:Paint(w,h)
        surface.SetDrawColor(colUp)
        surface.DrawRect(0,5,w,h)
    end
    function pBar.btnDown:Paint( w, h )
        surface.SetDrawColor(colDown)
        surface.DrawRect(0,5,w,h)
    end
    function pBar.btnGrip:Paint( w, h )
        surface.SetDrawColor(colGrip)
        surface.DrawRect(0,5,w,h)
    end  

    return self
end

function PANEL:SetSearchBar(p,val)
    if !IsValid(p) then return end

    p.OnChange = function(p)
        local strText = p:GetValue()

        local tblChildrens = self:GetChildren()

        if IsValid(self.pIconLayout) then 
            tblChildrens = self.pIconLayout:GetChildren() 
        end

        for k,v in pairs(tblChildrens or {}) do
            local str = v[val] or ""
            if (str:StartWith("#")) then str = str:sub(2) end
            str = language.GetPhrase(str)

            if (string.find(str:lower(),strText:lower()) || string.len(strText) < 2 ) then
                v:SetVisible(true)
            else
                v:SetVisible(false)
            end

            v:InvalidateLayout()
        end

        self:InvalidateLayout()

        if IsValid(self.pIconLayout) then
            self.pIconLayout:Layout()
        end
    end

    return self
end

function PANEL:SetHideButtons(bool)
    self:GetVBar():SetHideButtons(true)

    return self
end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DScrollPanel",function()
    vgui.Register("GCore:DScrollPanel",PANEL,"DScrollPanel")
end)