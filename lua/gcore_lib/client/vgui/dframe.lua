--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local PANEL = {}

function PANEL:Init()
    self:SetTitle('')
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

function PANEL:Paint(w,h)
    surface.SetDrawColor(0,0,0,200)
    surface.DrawRect(0,0,w,h)

    if self.tblHeader then
        surface.SetDrawColor(GCore.Lib:GetColor("black"))
        surface.DrawRect(0,0,w,self.tblHeader.height)
        draw.SimpleText(self.tblHeader.text,"Trebuchet24",self.tblHeader.marginLeft or 0,self.tblHeader.height/2,color_white,0,1)
    end
end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DFrame",function()
    vgui.Register("GCore:DFrame",PANEL,"DFrame")
end)