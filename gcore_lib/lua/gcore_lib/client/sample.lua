--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

GCore.Lib.Sample = GCore.Lib.Sample or {}

function GCore.Lib.Sample:Reset()
    if IsValid(GCore.Lib.Sample.Panel) then GCore.Lib.Sample.Panel:Remove() end
end

function GCore.Lib.Sample:Sample()
    local frame = vgui.Create("GCore:DFrame")
        :SetSize(700,250)
        :SetHeader("G-Core Lib",50,{marginRight = 10})
        :Center()
        :SetDraggable(true)
        :MakePopup()
        function frame:PaintOver(w,h)
            local intMaringTop = self.tblHeader.height
            draw.SimpleText( "Présentation G-Core Lib !", GCore.Lib:GetFont(24,"Roboto"),w/2,intMaringTop+15,color_white,1)
        end

    local pName = vgui.Create("GCore:DTextEntry",frame)
        :SetSize(frame:GetWide()-20,40)
        :SetPos(10,100)
        :SetFont(GCore.Lib:GetFont(18,"Roboto"))
        :SetLabel('Votre Prénom',{type="fas",size=18,unicode="f4ff"})
        :SetPlaceholderText('Entrez votre prénom...')

    local pAge = vgui.Create("GCore:DTextEntry",frame)
        :SetSize(frame:GetWide()-20,40)
        :SetPos(10,150)
        :SetFont(GCore.Lib:GetFont(18,"Roboto"))
        :SetLabel('Votre Age',{type="fas",size=18,unicode="f1fd"})
        :SetPlaceholderText('Entrez votre âge...')
        
    local btnValid = vgui.Create("GCore:DButton",frame)
        :SetSize(frame:GetWide()-20,40)
        :SetPos(10,200)
        :SetFont(GCore.Lib:GetFont(18,"Roboto"))
        :SetDefaultText('Valider',{type="fas",size=18,unicode="f00c"})

    GCore.Lib.Sample.Panel = frame
end

GCore.Lib.Sample:Reset()
GCore.Lib.Sample:Sample()