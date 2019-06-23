--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

local PANEL = {}

function PANEL:Init()
    self.boolCanTurn = false
end

function PANEL:SetModel( strModelName )
	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
		self.Entity = nil
	end

	if ( !ClientsideModel ) then return self end

	self.Entity = ClientsideModel( strModelName, RENDERGROUP_OTHER )
	if ( !IsValid( self.Entity ) ) then return self end

	self.Entity:SetNoDraw( true )
	self.Entity:SetIK( false )

	local iSeq = self.Entity:LookupSequence( "walk_all" )
	if ( iSeq <= 0 ) then iSeq = self.Entity:LookupSequence( "WalkUnarmed_all" ) end
	if ( iSeq <= 0 ) then iSeq = self.Entity:LookupSequence( "walk_all_moderate" ) end

	if ( iSeq > 0 ) then self.Entity:ResetSequence( iSeq ) end

    return self
end

function PANEL:LayoutEntity(ent)
    if self.boolCanTurn then        
        if self:IsDown() then
            local curposx, curposy = self:CursorPos()

            if self.prevx == nil or self.prevy == nil then self.prevx, self.prevy = curposx, curposy end

            ent:SetAngles( Angle( 0, -( self.prevx - curposx ), 0 ) )
        else
            self.prevx, self.prevy = nil, nil
        end
    else
        if ( self.bAnimated ) then
            self:RunAnimation()
        end

        ent:SetAngles( Angle( 0, RealTime() * 10 % 360, 0 ) )
    end
end

function PANEL:CanTurn(bool)
    self.boolCanTurn = bool

    return self
end

function PANEL:CenterModel()
    local mn, mx = self.Entity:GetRenderBounds()
    local size = 0
    size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
    size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
    size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

    self:SetFOV( 45 )
    self:SetCamPos( Vector( size, size, size ) )
    self:SetLookAt( ( mn + mx ) * 0.5 )

    -- Merci le wiki
    return self
end

hook.Add("GCore:Lib:CanCreateVgui","GCore:Lib:DModelPanel",function()
    vgui.Register("GCore:DModelPanel",PANEL,"DModelPanel")
end)