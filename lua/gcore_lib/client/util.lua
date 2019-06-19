--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local blur = Material("pp/blurscreen")
function GCore.Lib:DrawBlur( p, a, d )
	local x, y = p:LocalToScreen( 0, 0 )

	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( blur )

	for i = 1, d do
		blur:SetFloat( "$blur", (i / d ) * ( a ) )
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
	end
end

function GCore.Lib:Confirm(strHeader,strText,tblParams,callbackAccept,callbackDecline)
	local strFont = GCore.Lib:GetFont(24,"Roboto")

	surface.SetFont(strFont)
	local intW, intH = surface.GetTextSize(strText)

	local parent = nil

	if tblParams && tblParams.blur then
		local blur = vgui.Create("GCore:DFrame")
			:SetSize(ScrW(),ScrH())
			:Center()
			:MakePopup()
			:FadeIn(0.5)
			:ShowCloseButton(false)
			:SetDraggable(false)
			function blur:Paint(w,h)
				GCore.Lib:DrawBlur(self,5,5)
				draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))				
			end	

		parent = blur
	end

	local frame = vgui.Create("GCore:DFrame",parent)
		:SetSize(intW+300,150)
		:Center()
		:MakePopup()
		:RemoveOnEscape(true,callbackDecline)
		:SetHeader(strHeader,50,{marginRight = 10})
		function frame:PaintOver(w,h)
			draw.SimpleText(strText,strFont,w/2,60,color_white,1)
		end
		function frame:OnRemove()
			if IsValid(parent) then parent:FadeOut(0.5,true) end
		end
	local btnAccept = vgui.Create("GCore:DButton",frame)
		:SetSize(150,30)
		:SetPos(frame:GetWide()/2-160,100)
		:SetFont(GCore.Lib:GetFont(18,"Roboto"))
		:SetDefaultText("Accepter")
		function btnAccept:DoClick()
			if callbackAccept then
				callbackAccept()
			end
			
			frame:Remove()
		end	
	
	local btnDecline = vgui.Create("GCore:DButton",frame)
		:SetSize(150,30)
		:SetPos(frame:GetWide()/2+10,100)
		:SetFont(GCore.Lib:GetFont(18,"Roboto"))
		:SetDefaultText("Refuser")
		function btnDecline:DoClick()
			if callbackDecline then
				callbackDecline()
			end

			frame:Remove()
		end

	return frame
end