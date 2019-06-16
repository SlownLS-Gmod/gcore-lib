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