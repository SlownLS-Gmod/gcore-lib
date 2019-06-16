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
        :SetSize(700,361)
        :SetHeader("G-Core Lib",50,{marginRight = 10})
        :Center()
        :SetDraggable(true)
        :MakePopup()
        function frame:PaintOver(w,h)
            local intMaringTop = 0
            if self.tblHeader then intMaringTop = self.tblHeader.height end

            draw.SimpleText( "Présentation G-Core Lib !", GCore.Lib:GetFont(24,"Roboto"),w/2,intMaringTop+15,color_white,1)
            draw.SimpleText( "Vous êtes :", GCore.Lib:GetFont(18,"Roboto"),10,intMaringTop+150,color_white)
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
        :SetNumeric(true)
        :SetLabel('Votre Age',{type="fas",size=18,unicode="f1fd"})
        :SetPlaceholderText('Entrez votre âge...')

    local pRadio = vgui.Create("GCore:DRadio",frame)

    for i = 1, 2 do        
        local strLabel = "Un Homme"
        if i == 2 then strLabel = "Une Femme" end

        local pCheckBox = vgui.Create("GCore:DCheckBox",frame)
            :SetSize(18,18)
            :SetPos(80,225+(i*25)-25)
            :SetLabel(strLabel, {
                font = GCore.Lib:GetFont(18,"Roboto"),
                color = color_white
            })
            :AddToRadio(pRadio)
            :SetValueRadio(i)

        pRadio:Select(1)
    end

    local pRules = vgui.Create("GCore:DCheckBox",frame)
        :SetSize(18,18)
        :SetPos(10,283)
        :SetLabel("En jouant sur le serveur, vous acceptez les règles.", {
            font = GCore.Lib:GetFont(18,"Roboto"),
            color = color_white
        })
        
    local btnValid = vgui.Create("GCore:DButton",frame)
        :SetSize(frame:GetWide()-20,40)
        :SetPos(10,311)
        :SetFont(GCore.Lib:GetFont(18,"Roboto"))
        :SetDefaultText('Valider',{type="fas",size=18,unicode="f00c"})
        function btnValid:DoClick()
            chat.AddText(GCore.Lib:GetColor('lightRed'),"----------------------------------------")
            chat.AddText(GCore.Lib:GetColor('lightRed'),"[G-Core] : ", color_white, "Prénom: " .. GCore.Lib:Ternary(string.len(pName:GetValue()) < 1,"Non défini",pName:GetValue()) )
            chat.AddText(GCore.Lib:GetColor('lightRed'),"[G-Core] : ", color_white, "Age: " .. GCore.Lib:Ternary(string.len(pAge:GetValue()) < 1,"Non défini",pAge:GetValue() .. " ans") )
            chat.AddText(GCore.Lib:GetColor('lightRed'),"[G-Core] : ", color_white, "Sexe: " .. GCore.Lib:Ternary(pRadio:GetValueRadio() == 1,"Homme","Femme") )
            chat.AddText(GCore.Lib:GetColor('lightRed'),"----------------------------------------")
        end

    GCore.Lib.Sample.Panel = frame
end

concommand.Add("gcore_lib_sample",function()
    GCore.Lib.Sample:Reset()
    GCore.Lib.Sample:Sample()
end)