--[[  
    Addon: Lib
    For: G-Core
    By: SlownLS ( www.g-core.fr )
]]

-- Load Font
resource.AddFile("resource/fonts/font-awesome-regular.ttf")
resource.AddFile("resource/fonts/font-awesome-solid.tff")

-- Load Workshop
resource.AddWorkshop('1774024252')

-- Check Version
local strUrlChecker = "https://pastebin.com/raw/tK1VK9fQ"
local intCurrentVersion = "1.0.3"
GCore.Lib.VersionIsGood = GCore.Lib.VersionIsGood or true 

function GCore.Lib:CheckVersion(pPlayer)
    http.Fetch( strUrlChecker, function(strBody)
        if !IsValid(pPlayer) then return end

        if string.len(strBody) > 0 then
            local tbl = util.JSONToTable(strBody)

            if !tbl then
                print("[G-Core Lib] - [Error] : Impossible d'éffectuer une requête au serveur github.")
                return 
            end

            if tbl.version != intCurrentVersion then
                GCore.Lib.VersionIsGood = false
                pPlayer:ChatPrint(tbl.msg)
                return 
            end
        else
            print("[G-Core Lib] - [Error] : Impossible d'éffectuer une requête au serveur github.")
        end
    end, function(strErr)
        print("[G-Core Lib] - [Error] : " .. strErr)
    end)

    return GCore.Lib.VersionIsGood
end

-- Player Initial Spawn
hook.Add("PlayerInitialSpawn","GCore:Lib:Checker:Spawn",function(pPlayer)
    timer.Simple(5,function()
        if !IsValid(pPlayer) then return end
        if !pPlayer:IsSuperAdmin() then return end

        GCore.Lib:CheckVersion(pPlayer)
    end)
end)