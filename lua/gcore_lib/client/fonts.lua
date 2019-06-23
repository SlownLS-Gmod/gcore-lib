local tblFontsCreated = {}

-- Function
function GCore.Lib:GetIcon(strType,intSize,unicode,tbl)
    strType = string.lower(strType)

    local tblFont = {
        size = intSize,
        weight = 500,
        extended = true
    }

    for k,v in pairs(tbl or {}) do
        tblFont[k] = v
    end

    if strType == "fas" || strType == "fa" then
        tblFont['font'] = "Font Awesome 5 Free Solid"
    elseif strType == "far" then
        tblFont['font'] = "Font Awesome 5 Free Regular"
    else
        return {text = "Type invalid", "Trebuchet18"}
    end

    local strFont = "GCore:Font:A:" .. strType .. ":" .. intSize

    if !tblFontsCreated[strFont..intSize] then        
        surface.CreateFont(strFont,tblFont)
        tblFontsCreated[strFont..intSize] = true 
    end

    return {
        text = utf8.char(tonumber("0x" .. unicode)),
        font = strFont
    }
end

function GCore.Lib:GetFont(intSize,strType,intWeight)
    intWeight = intWeight or 500

    local strFont = "GCore:Font:" .. strType .. ":" .. intSize .. ":" .. intWeight

    if !tblFontsCreated[strFont] then            
        surface.CreateFont(strFont,{
            font = strType,
            size = intSize,
            weight = intWeight or 500
        })

        tblFontsCreated[strFont] = true 
    end

    return strFont
end
