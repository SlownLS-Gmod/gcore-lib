--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

GCore.Lib.Sample = GCore.Lib.Sample or {}

local tblInfos = {}
local tblModels = {
    "models/player/Group01/Female_01.mdl",
    "models/player/Group01/Female_02.mdl",
    "models/player/Group01/Female_03.mdl",
    "models/player/Group01/Female_04.mdl",
    "models/player/Group01/Female_06.mdl",
    "models/player/group01/male_01.mdl",
    "models/player/Group01/Male_02.mdl",
    "models/player/Group01/male_03.mdl",
    "models/player/Group01/Male_04.mdl",
    "models/player/Group01/Male_05.mdl",
    "models/player/Group01/Male_06.mdl",
    "models/player/Group01/Male_07.mdl",
    "models/player/Group01/Male_08.mdl",
    "models/player/Group01/Male_09.mdl"
}

function GCore.Lib.Sample:Reset()
    if IsValid(GCore.Lib.Sample.Panel) then GCore.Lib.Sample.Panel:Remove() end
end

function GCore.Lib.Sample:ChoosePlayer()
    local frame = vgui.Create("GCore:DFrame")
        :SetSize(700,361)
        :SetHeader("G-Core Lib",50,{marginRight = 10})
        :Center()
        :SetDraggable(true)
        :MakePopup()
        :FadeIn(0.5)
        function frame:PaintOver(w,h)
            surface.SetDrawColor(GCore.Lib:GetColor('primary'))
            surface.DrawRect(220,60,3,h-70)
        end

    local pModel = vgui.Create("GCore:DModelPanel",frame)
        :SetSize(200,frame:GetTall()-110)
        :SetPos(10,60)
        :SetModel(tblModels[1]) 
        :SetFOV( 18 )
	    :SetCamPos( Vector( 210, 0, 70 ) )
	    :SetLookAt( Vector( 0, 0, 36 ) )
        :CanTurn(true)


    local btnValid = vgui.Create("GCore:DButton",frame)
        :SetSize(200,30)
        :SetPos(10,frame:GetTall()-30-10)
        :SetFont(GCore.Lib:GetFont(18,"Roboto"))
        :SetDefaultText('Valider',{type="fas",size=18,unicode="f00c"})        

    local pSearch = vgui.Create("GCore:DTextEntry",frame)
        :SetSize(frame:GetWide()-240,30)
        :SetPos(230,60)
        :SetFont(GCore.Lib:GetFont(16,"Roboto"))
        :SetLabel('Nom du model',{type="fas",size=18,unicode="f002"})

    local pList = vgui.Create("GCore:DScrollPanel",frame)
        :SetSize(frame:GetWide()-240,frame:GetTall()-110)
        :SetPos(230,100)
        :AddIconLayout(10,10)
        :SetSearchBar(pSearch,"model")

    for k,v in SortedPairs(tblModels or {}) do
        local pMdl = vgui.Create("GCore:DModelPanel",pList:GetIconLayout())
            :SetSize(100,140)
            :SetModel(v)
            :CanTurn(true)
            :SetFOV(45)
            pMdl.model = v
            function pMdl:DoClick()
                pModel:SetModel(v)
            end
            function pMdl:PaintOver(w,h)
                local col = GCore.Lib:LerpColor(
                    self,
                    "borderColor",
                    { 
                        default = Color(0,0,0,0),
                        to = GCore.Lib:GetColor('lightRed')
                    },
                    string.upper(pModel:GetModel()) == string.upper(v),
                    7
                )

                surface.SetDrawColor(col)
                surface.DrawOutlinedRect(0,0,w,h)
            end                  
    end
end

function GCore.Lib.Sample:Sample()
    local frame = vgui.Create("GCore:DFrame")
        :SetSize(700,361)
        :SetHeader("G-Core Lib",50,{marginRight = 10})
        :Center()
        :SetDraggable(true)
        :MakePopup()
        :FadeIn(0.5)
        -- :SetBorderRadius(8)
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
        -- :SetBorderRadius(8)

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
        -- :SetBorderRadius(8)
        function btnValid:DoClick()
            GCore.Lib:Confirm("Confirmez ?","Confirmez-vous ces informations ?",{blur=true}, function()
                    chat.AddText(GCore.Lib:GetColor('lightRed'),"----------------------------------------")
                    chat.AddText(GCore.Lib:GetColor('lightRed'),"[G-Core] : ", color_white, "Prénom: " .. GCore.Lib:Ternary(string.len(pName:GetValue()) < 1,"Non défini",pName:GetValue()) )
                    chat.AddText(GCore.Lib:GetColor('lightRed'),"[G-Core] : ", color_white, "Age: " .. GCore.Lib:Ternary(string.len(pAge:GetValue()) < 1,"Non défini",pAge:GetValue() .. " ans") )
                    chat.AddText(GCore.Lib:GetColor('lightRed'),"[G-Core] : ", color_white, "Sexe: " .. GCore.Lib:Ternary(pRadio:GetValueRadio() == 1,"Homme","Femme") )
                    chat.AddText(GCore.Lib:GetColor('lightRed'),"----------------------------------------")

                    tblInfos.name = GCore.Lib:Ternary(string.len(pName:GetValue()) < 1,"Non défini",pName:GetValue())
                    tblInfos.age = GCore.Lib:Ternary(string.len(pAge:GetValue()) < 1,"Non défini",pAge:GetValue() .. " ans")
                    tblInfos.sexe = GCore.Lib:Ternary(pRadio:GetValueRadio() == 1,"Homme","Femme")

                    frame:FadeOut(0.5,true,function()
                    GCore.Lib.Sample:ChoosePlayer()
                end)
            end)
        end

    GCore.Lib.Sample.Panel = frame
end

concommand.Add("gcore_lib_sample",function()
    GCore.Lib.Sample:Reset()
    GCore.Lib.Sample:Sample()
end)