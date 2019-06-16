--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

GCore = GCore or {}
GCore.Lib = GCore.Lib or {}

GCore.Lib.DevMode = false

function GCore.Lib:AddFile(strPath,boolInclude)
	local files, folders = file.Find(strPath .. "*","LUA")
    
	for _,v in pairs(files or { }) do
		if boolInclude then
			include(strPath .. v)
		else
			AddCSLuaFile(strPath .. v)
		end
	end

	for _,v in pairs(folders) do
		self:AddFile(strPath .. v .. "/",boolInclude)
	end
end

if ( SERVER ) then
	-- Load Shared Files
	GCore.Lib:AddFile("gcore_lib/shared/",true)
	GCore.Lib:AddFile("gcore_lib/shared/",false)

	-- Load Server Files
	GCore.Lib:AddFile("gcore_lib/server/",true)

	-- Load Client Files
	GCore.Lib:AddFile("gcore_lib/client/",false)

	-- Load Themes Files
	GCore.Lib:AddFile("gcore_lib/themes/",true)
	GCore.Lib:AddFile("gcore_lib/themes/",false)

	print("--------------------------------------------------")
	print("|| 	G-Core Lib Loaded! | Addon By SlownLS 	||")
	print("--------------------------------------------------")

	return 
end

-- Load Shared Files
GCore.Lib:AddFile("gcore_lib/shared/",true)

-- Load Client Files
GCore.Lib:AddFile("gcore_lib/client/",true)

-- Load Themes Files
GCore.Lib:AddFile("gcore_lib/themes/",true)