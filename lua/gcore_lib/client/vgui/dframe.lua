--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local PANEL = {}

function PANEL:Init()
    self:SetTitle('')
    self.colBackground = GCore.Lib:GetColor('background')
    self.colHeader = GCore.Lib:GetColor('primary')
    self.colHeaderText = color_white
end

function PANEL:SetHeader(strText,intHeight, tblBtnClose, intMLeft )
    if tblBtnClose && tblBtnClose.marginRight then
        self:ShowCloseButton(false)

        local tblIcon = GCore.Lib:GetIcon("fas",18,"f057")

        local btnClose = vgui.Create("GCore:DButton", self )
            btnClose:SetSize(32,32)
            btnClose:SetPos(self:GetWide()-btnClose:GetWide()-tblBtnClose.marginRight,intHeight/2-btnClose:GetTall()/2)
            btnClose:SetText('')
        
            btnClose.DoClick = function(btn)
                self:Remove()
            end

            btnClose.Paint = function(btn,w,h)
                local col = GCore.Lib:LerpColor(
                    btn,
                    "btnClose",
                    { 
                        default = GCore.Lib:GetColor("lightRed"),
                        to = GCore.Lib:GetColor("red")
                    },
                    btn:IsHovered(),
                    7
                )

                draw.SimpleText(tblIcon.text,tblIcon.font,w/2,h/2,col,1,1)
            end
    end

    self.tblHeader = {
        text = strText,
        height = intHeight or 80,
        marginLeft = intMLeft or 15
    }

    return self
end

function PANEL:SetHeaderColor(col,colText)
    self.colHeader = col
    self.colHeaderText = colText

    return self
end

function PANEL:UnPopup()
    self:SetMouseInputEnabled(false)
    self:SetKeyboardInputEnabled(false)

    return self
end

function PANEL:SetBackgroundColor(col)
    self.colBackground = col

    return self
end

function PANEL:Paint(w,h)
    surface.SetDrawColor(self.colBackground)
    surface.DrawRect(0,0,w,h)

    if self.tblHeader then
        surface.SetDrawColor(self.colHeader)
        surface.DrawRect(0,0,w,self.tblHeader.height)
        draw.SimpleText(self.tblHeader.text,"Trebuchet24",self.tblHeader.marginLeft or 0,self.tblHeader.height/2,self.colHeaderText,0,1)
    end
end

function PANEL:FadeIn(intTime)
    self:SetAlpha(0)

    self:AlphaTo(255,intTime,0)

    return self
end

function PANEL:FadeOut(intTime,boolClose,cb)
    self:AlphaTo(0,intTime,0,function()
        if cb then cb() end
        if boolClose then self:Remove() end
    end)
end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DFrame",function()
    vgui.Register("GCore:DFrame",PANEL,"DFrame")
end)